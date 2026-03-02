#!/usr/bin/env bash
set -euo pipefail

required_paths=(
  "config/app.yaml"
  "config/plugin-types.yaml"
  "templates/shell-script"
  "templates/agent-tool"
  "templates/llm-skill"
  "registry/index.json"
)

for p in "${required_paths[@]}"; do
  if [ ! -e "$p" ]; then
    echo "缺少必要路径: $p"
    exit 1
  fi
done

if ! command -v python >/dev/null 2>&1; then
  echo "未安装 python"
  exit 1
fi

echo "结构检查通过"
