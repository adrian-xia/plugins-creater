#!/bin/bash

set -e

echo "Building codex-switch..."
cargo build --release

echo "Installing to /usr/local/bin..."
sudo cp target/release/codex-switch /usr/local/bin/

echo "✓ Installation complete!"
echo ""
echo "Next steps:"
echo "1. Register a source: codex-switch register official"
echo "2. Add your config files to ~/.codex/auth/official/"
echo "3. Switch to it: codex-switch official"
echo "4. Install completions: codex-switch install zsh >> ~/.zshrc"
