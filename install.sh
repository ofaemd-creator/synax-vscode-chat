#!/usr/bin/env bash
set -euo pipefail

echo "============================================================"
echo "  SYNAX Chat & Studio IDE v2.0.0 — Universal VS Code Installer"
echo "============================================================"

VSIX_URL="https://github.com/ofaemd-creator/synax-vscode-chat/releases/download/v2.0.0/synax-vscode-chat-2.0.0.vsix"
TMP_VSIX="/tmp/synax-vscode-chat-2.0.0.vsix"

echo "[1/2] Downloading synax-vscode-chat-2.0.0.vsix from GitHub Releases..."
curl -fsSL "$VSIX_URL" -o "$TMP_VSIX"

INSTALLED=0

for BIN in \
  "code" \
  "/Applications/Visual Studio Code.app/Contents/Resources/app/bin/code" \
  "cursor" \
  "/Applications/Cursor.app/Contents/Resources/app/bin/cursor" \
  "antigravity-ide" \
  "/Applications/Antigravity IDE.app/Contents/Resources/app/bin/antigravity-ide" \
  "windsurf" \
  "/Applications/Windsurf.app/Contents/Resources/app/bin/windsurf"
do
  if command -v "$BIN" >/dev/null 2>&1 || [ -x "$BIN" ]; then
    echo "[2/2] Installing into: $BIN"
    "$BIN" --install-extension "$TMP_VSIX" --force || true
    INSTALLED=1
  fi
done

if [ "$INSTALLED" -eq 0 ]; then
  echo "Done downloading: $TMP_VSIX"
  echo "Open VS Code -> Extensions (Cmd+Shift+X / Ctrl+Shift+X) -> ... -> Install from VSIX -> select $TMP_VSIX"
else
  echo "SUCCESS! Restart or Reload Window in VS Code to see the SYNAX icon on the left Activity Bar."
fi
