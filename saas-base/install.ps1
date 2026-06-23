# install.ps1 — instala o SaaS Base num projeto alvo.
# Uso:  .\install.ps1 -Target "C:\caminho\do\projeto"
param(
  [Parameter(Mandatory = $true)][string]$Target
)

$ErrorActionPreference = "Stop"
$src = $PSScriptRoot

if (-not (Test-Path $Target)) { throw "Pasta alvo nao existe: $Target" }

# 1. Skills + agentes -> .claude/
$dstClaude = Join-Path $Target ".claude"
New-Item -ItemType Directory -Force -Path (Join-Path $dstClaude "skills") | Out-Null
New-Item -ItemType Directory -Force -Path (Join-Path $dstClaude "agents") | Out-Null
Copy-Item (Join-Path $src ".claude\skills\*") (Join-Path $dstClaude "skills") -Recurse -Force
Copy-Item (Join-Path $src ".claude\agents\*") (Join-Path $dstClaude "agents") -Recurse -Force
Write-Host "[ok] skills + agentes copiados para .claude/"

# 2. MCP servers -> .mcp.json (merge nao-destrutivo)
$srcMcp = Get-Content (Join-Path $src ".mcp.json") -Raw | ConvertFrom-Json
$dstMcpPath = Join-Path $Target ".mcp.json"
if (Test-Path $dstMcpPath) {
  $dstMcp = Get-Content $dstMcpPath -Raw | ConvertFrom-Json
} else {
  $dstMcp = [pscustomobject]@{ mcpServers = [pscustomobject]@{} }
}
if (-not $dstMcp.mcpServers) { $dstMcp | Add-Member mcpServers ([pscustomobject]@{}) -Force }
foreach ($name in $srcMcp.mcpServers.PSObject.Properties.Name) {
  $dstMcp.mcpServers | Add-Member $name $srcMcp.mcpServers.$name -Force
}
$dstMcp | ConvertTo-Json -Depth 10 | Out-File $dstMcpPath -Encoding utf8
Write-Host "[ok] MCP servers (context7, playwright) adicionados a .mcp.json"

# 3. Regras -> CLAUDE.md (idempotente, entre marcadores)
$rules = Get-Content (Join-Path $src "CLAUDE.rules.md") -Raw
$claudeMd = Join-Path $Target "CLAUDE.md"
if (Test-Path $claudeMd) {
  $body = Get-Content $claudeMd -Raw
  if ($body -match '(?s)<!-- SAAS-BASE-RULES:START.*?SAAS-BASE-RULES:END -->') {
    $body = [regex]::Replace($body, '(?s)<!-- SAAS-BASE-RULES:START.*?SAAS-BASE-RULES:END -->', $rules.TrimEnd())
  } else {
    $body = $body.TrimEnd() + "`r`n`r`n" + $rules
  }
  $body | Out-File $claudeMd -Encoding utf8
} else {
  $rules | Out-File $claudeMd -Encoding utf8
}
Write-Host "[ok] regras aplicadas em CLAUDE.md"

# 4. Pasta plans/ (memoria do projeto, append-only)
New-Item -ItemType Directory -Force -Path (Join-Path $Target "plans") | Out-Null
Write-Host "[ok] pasta plans/ criada"

Write-Host ""
Write-Host "Pronto. Reinicie o Claude Code no projeto para carregar skills + MCPs."
Write-Host "Supabase e PostHog continuam no seu setup global (nao mexidos)."
