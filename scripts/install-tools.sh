#!/usr/bin/env bash
# 工具安装脚本 - 将 tools/ 下的工具链接到 /usr/local/bin

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(cd "${SCRIPT_DIR}/.." && pwd)"
TOOLS_DIR="${PROJECT_ROOT}/tools"

print_help() {
  cat <<'EOF'
Usage: install-tools.sh [options]

Options:
  --list          列出所有可用工具
  --install <tool> 安装指定工具
  --install-all   安装所有工具
  --uninstall <tool> 卸载指定工具
  --help          显示帮助信息

Examples:
  ./install-tools.sh --list
  ./install-tools.sh --install claude-switch
  ./install-tools.sh --install-all
  ./install-tools.sh --uninstall testbox

Note:
  codex-switch 需要先构建 Rust 二进制文件：
    cd tools/codex-switch && cargo build --release
EOF
}

list_tools() {
  echo "Available tools:"
  for tool_dir in "${TOOLS_DIR}"/*; do
    if [ -d "${tool_dir}" ]; then
      tool_name=$(basename "${tool_dir}")
      tool_bin="${tool_dir}/${tool_name}"

      if [ -f "${tool_bin}" ]; then
        echo "  - ${tool_name}"
      elif [ "${tool_name}" = "codex-switch" ]; then
        # Check for Rust binary
        rust_bin="${tool_dir}/target/release/${tool_name}"
        if [ -f "${rust_bin}" ]; then
          echo "  - ${tool_name} (Rust binary)"
        else
          echo "  - ${tool_name} (needs build: cd tools/codex-switch && cargo build --release)"
        fi
      fi
    fi
  done
}

install_tool() {
  local tool_name="$1"
  local tool_dir="${TOOLS_DIR}/${tool_name}"
  local tool_bin="${tool_dir}/${tool_name}"
  local target="/usr/local/bin/${tool_name}"

  if [ ! -d "${tool_dir}" ]; then
    echo "Error: Tool directory not found: ${tool_dir}"
    return 1
  fi

  # Special handling for codex-switch (Rust binary)
  if [ "${tool_name}" = "codex-switch" ]; then
    local rust_bin="${tool_dir}/target/release/${tool_name}"
    if [ -f "${rust_bin}" ]; then
      tool_bin="${rust_bin}"
    else
      echo "Error: codex-switch binary not found. Please build it first:"
      echo "  cd tools/codex-switch && cargo build --release"
      return 1
    fi
  fi

  if [ ! -f "${tool_bin}" ]; then
    echo "Error: Tool binary not found: ${tool_bin}"
    return 1
  fi

  if [ -L "${target}" ]; then
    echo "Removing existing symlink: ${target}"
    sudo rm "${target}"
  elif [ -e "${target}" ]; then
    echo "Error: ${target} exists and is not a symlink"
    return 1
  fi

  sudo ln -s "${tool_bin}" "${target}"
  echo "✓ Installed: ${tool_name} -> ${target}"
}

uninstall_tool() {
  local tool_name="$1"
  local target="/usr/local/bin/${tool_name}"

  if [ ! -L "${target}" ]; then
    echo "Tool not installed: ${tool_name}"
    return 0
  fi

  sudo rm "${target}"
  echo "✓ Uninstalled: ${tool_name}"
}

install_all() {
  for tool_dir in "${TOOLS_DIR}"/*; do
    if [ -d "${tool_dir}" ]; then
      tool_name=$(basename "${tool_dir}")
      tool_bin="${tool_dir}/${tool_name}"

      # Check for regular binary or Rust binary
      if [ -f "${tool_bin}" ]; then
        install_tool "${tool_name}"
      elif [ "${tool_name}" = "codex-switch" ]; then
        rust_bin="${tool_dir}/target/release/${tool_name}"
        if [ -f "${rust_bin}" ]; then
          install_tool "${tool_name}"
        else
          echo "Skipping ${tool_name}: needs build first"
        fi
      fi
    fi
  done
}

if [ "$#" -eq 0 ]; then
  print_help
  exit 1
fi

case "$1" in
  --list)
    list_tools
    ;;
  --install)
    if [ "$#" -lt 2 ]; then
      echo "Error: Missing tool name"
      exit 1
    fi
    install_tool "$2"
    ;;
  --install-all)
    install_all
    ;;
  --uninstall)
    if [ "$#" -lt 2 ]; then
      echo "Error: Missing tool name"
      exit 1
    fi
    uninstall_tool "$2"
    ;;
  --help|-h)
    print_help
    ;;
  *)
    echo "Error: Unknown option: $1"
    print_help
    exit 1
    ;;
esac
