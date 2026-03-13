#!/usr/bin/env bash
set -euo pipefail

echo "验证工具集合..."
echo

# 验证 claude-switch
echo "✓ claude-switch"
./claude-switch/claude-switch list > /dev/null
echo "  - 可执行文件正常"
echo "  - 配置文件存在: $(ls claude-switch/config/*.json | wc -l | tr -d ' ') 个"

# 验证 codex-switch
echo
echo "✓ codex-switch"
if [ -f codex-switch/src/main.rs ]; then
    echo "  - Rust 源码存在"
fi
if [ -f codex-switch/Cargo.toml ]; then
    echo "  - Cargo.toml 存在"
fi
if [ -f codex-switch/install.sh ]; then
    echo "  - 安装脚本存在"
fi

# 验证 testbox
echo
echo "✓ testbox"
./testbox/testbox help > /dev/null
echo "  - 可执行文件正常"
if [ -f testbox/docker/Dockerfile ]; then
    echo "  - Dockerfile 存在"
fi

echo
echo "所有工具验证通过！"
