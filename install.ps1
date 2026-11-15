$ErrorActionPreference = "Stop"
Write-Host "============================================================" -ForegroundColor Cyan
Write-Host "  SYNAX Chat & Studio IDE v2.0.0 — Windows VS Code Installer" -ForegroundColor Cyan
Write-Host "============================================================" -ForegroundColor Cyan

$VsixUrl = "https://github.com/ofaemd-creator/synax-vscode-chat/releases/download/v2.0.0/synax-vscode-chat-2.0.0.vsix"
$TmpVsix = Join-Path $env:TEMP "synax-vscode-chat-2.0.0.vsix"

Write-Host "[1/2] Downloading synax-vscode-chat-2.0.0.vsix..."
Invoke-WebRequest -Uri $VsixUrl -OutFile $TmpVsix

$Bins = @(
  "code",
  "$env:LOCALAPPDATA\Programs\Microsoft VS Code\bin\code.cmd",
  "cursor",
  "$env:LOCALAPPDATA\Programs\cursor\resources\app\bin\cursor.cmd"
)

$Installed = $false
foreach ($Bin in $Bins) {
  if (Get-Command $Bin -ErrorAction SilentlyContinue) {
    Write-Host "[2/2] Installing into $Bin..." -ForegroundColor Green
    & $Bin --install-extension $TmpVsix --force
    $Installed = $true
  }
}

if (-not $Installed) {
  Write-Host "Downloaded to: $TmpVsix" -ForegroundColor Yellow
  Write-Host "In VS Code: press Ctrl+Shift+X -> click ... -> Install from VSIX -> choose $TmpVsix"
} else {
  Write-Host "SUCCESS! Reload VS Code to see the SYNAX icon in the Activity Bar." -ForegroundColor Green
}
