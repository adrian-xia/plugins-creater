#!/usr/bin/env bash
set -euo pipefail

INSTALL_DIR="${HOME}/.local/bin"

mkdir -p "${INSTALL_DIR}"

cp "$(dirname "$0")/claude-switch" "${INSTALL_DIR}/claude-switch"
chmod +x "${INSTALL_DIR}/claude-switch"

echo "✓ Installed claude-switch to ${INSTALL_DIR}/"
echo ""
echo "Run 'claude-switch install zsh' to enable shell completions"