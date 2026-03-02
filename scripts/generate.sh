#!/usr/bin/env bash
set -euo pipefail

if [ "$#" -ne 2 ]; then
  echo "用法: $0 <shell-script|agent-tool|llm-skill> <name>"
  exit 1
fi

TYPE="$1"
NAME="$2"

./bin/pc generate --type "$TYPE" --name "$NAME"
