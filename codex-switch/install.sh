#!/usr/bin/env bash
set -euo pipefail

INSTALL_DIR="${HOME}/.local/bin"

mkdir -p "${INSTALL_DIR}"

cp "$(dirname "$0")/codex-switch" "${INSTALL_DIR}/codex-switch"
chmod +x "${INSTALL_DIR}/codex-switch"

echo "✓ Installed codex-switch to ${INSTALL_DIR}/"