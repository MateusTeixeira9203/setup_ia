# install.ps1 — instala o SaaS Base num projeto alvo.
# Uso:  .\install.ps1 -Target "C:\caminho\do\projeto"
# Obs: e ADITIVO (nao apaga skills existentes do alvo). Idempotente.
param(
  [Parameter(Mandatory = $true)][string]$Target
)

$ErrorActionPreference = "Stop"
$src = $PSScriptRoot

if (-not (Test-Path $Target)) { throw "Pasta alvo nao existe: $Target" }

# Grava UTF-8 SEM BOM (Out-File -Encoding utf8 no PS 5.1 poe BOM e quebra o parser do .mcp.json).
function Write-Utf8NoBom([string]$Path, [string]$Content) {
  $enc = New-Object System.Text.UTF8Encoding($false)
  [System.IO.File]::WriteAllText($Path, $Content, $enc)
}

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
Write-Utf8NoBom $dstMcpPath ($dstMcp | ConvertTo-Json -Depth 10)
Write-Host "[ok] MCP servers (context7, playwright) adicionados a .mcp.json"

# 3. Regras -> CLAUDE.md (idempotente, via split por marcador — sem regex)
$rules = (Get-Content (Join-Path $src "CLAUDE.rules.md") -Raw).TrimEnd()
$claudeMd = Join-Path $Target "CLAUDE.md"
$startMark = "<!-- SAAS-BASE-RULES:START"
$endMark = "SAAS-BASE-RULES:END -->"
if (Test-Path $claudeMd) {
  $body = Get-Content $claudeMd -Raw
  $si = $body.IndexOf($startMark)
  $ei = $body.IndexOf($endMark)
  if ($si -ge 0 -and $ei -ge 0) {
    # Substitui o bloco existente entre os marcadores (atualizacao limpa)
    $before = $body.Substring(0, $si)
    $after = $body.Substring($ei + $endMark.Length)
    $body = $before.TrimEnd() + "`r`n`r`n" + $rules + $after
  } else {
    # Anexa o bloco no fim, sem tocar no resto do CLAUDE.md
    $body = $body.TrimEnd() + "`r`n`r`n" + $rules + "`r`n"
  }
  Write-Utf8NoBom $claudeMd $body
} else {
  Write-Utf8NoBom $claudeMd ($rules + "`r`n")
}
Write-Host "[ok] regras aplicadas em CLAUDE.md"

# 4. Pasta plans/ (memoria do projeto, append-only)
New-Item -ItemType Directory -Force -Path (Join-Path $Target "plans") | Out-Null
Write-Host "[ok] pasta plans/ criada"

Write-Host ""
Write-Host "Pronto. Reinicie o Claude Code no projeto para carregar skills + MCPs."
Write-Host "Supabase e PostHog continuam no seu setup global (nao mexidos)."
