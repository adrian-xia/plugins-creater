# 工具管理指南

本项目提供了一套自定义工具，位于 `tools/` 目录下。

## 目录结构

```
tools/
├── claude-switch/    # Claude Code 配置切换工具
│   ├── claude-switch
│   ├── config/
│   └── README.md
├── codex-switch/     # Codex 认证配置切换工具（Rust）
│   ├── src/
│   ├── Cargo.toml
│   ├── install.sh
│   └── README.md
└── testbox/          # Docker 测试容器管理工具
    ├── testbox
    ├── docker/
    └── README.md
```

## 快速开始

### 列出所有工具

```bash
make list-tools
```

### 安装所有工具

```bash
make install-tools
```

### 安装指定工具

```bash
make install-tools tool=claude-switch
make install-tools tool=testbox
```

### 卸载工具

```bash
./scripts/install-tools.sh --uninstall claude-switch
```

## 工具说明

### claude-switch

快速切换 Claude Code 配置预设的工具。

**使用方法：**
```bash
claude-switch list
claude-switch official
claude-switch use proxy-main
```

详见：`tools/claude-switch/README.md`

### codex-switch

用于切换 Codex 认证配置的 Rust 工具。

**安装前置要求：**
```bash
# 安装 Rust
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
source $HOME/.cargo/env
```

**构建和安装：**
```bash
cd tools/codex-switch
./install.sh
```

**使用方法：**
```bash
codex-switch register official
codex-switch official
codex-switch list
```

详见：`tools/codex-switch/README.md`

### testbox

轻量级 Docker 测试容器管理工具。

**使用方法：**
```bash
testbox start
testbox exec "ls -la"
testbox shell
testbox stop
```

详见：`tools/testbox/README.md`

## 开发新工具

1. 在 `tools/` 下创建新目录，目录名即为工具名
2. 创建与目录同名的可执行文件
3. 添加 README.md 说明文档
4. 使用 `make install-tools tool=<tool-name>` 安装

**示例结构：**
```
tools/
└── my-tool/
    ├── my-tool          # 可执行文件（必需）
    ├── README.md        # 说明文档（推荐）
    └── config/          # 配置文件（可选）
```
