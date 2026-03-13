# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## 项目概述

这是一个个人开发工具集合，包含三个独立的工具项目：
- **claude-switch**: Claude Code 配置快速切换工具（Bash）
- **codex-switch**: Codex 认证配置切换工具（Rust）
- **testbox**: Docker 测试容器管理工具（Bash + Docker）

## 设计原则

- **独立完整**：每个工具目录都是一个完整的项目，可以单独拿出来使用
- **互不干扰**：工具之间没有依赖关系，可以独立开发和维护
- **单一职责**：每个工具专注于解决一个特定问题

## 目录结构

```
.
├── README.md           # 根目录索引，链接到各工具
├── claude-switch/      # 独立工具项目
│   ├── README.md
│   ├── claude-switch   # 可执行文件
│   └── config/
├── codex-switch/       # 独立工具项目
│   ├── README.md
│   ├── Cargo.toml
│   ├── src/
│   └── install.sh
└── testbox/            # 独立工具项目
    ├── README.md
    ├── testbox         # 可执行文件
    └── docker/
```

## 工具说明

### claude-switch
- **语言**: Bash
- **入口**: `claude-switch/claude-switch`
- **配置**: `claude-switch/config/profiles.json`
- **功能**: 通过修改 `~/.claude/settings.json` 切换不同的 Claude API 配置

### codex-switch
- **语言**: Rust
- **入口**: `codex-switch/src/main.rs`
- **构建**: `cargo build --release`
- **安装**: `./install.sh` 或 `cargo install --path .`
- **功能**: 管理 `~/.codex/auth/` 下的多个认证配置，支持快速切换

### testbox
- **语言**: Bash + Docker
- **入口**: `testbox/testbox`
- **Dockerfile**: `testbox/docker/Dockerfile`
- **功能**: 提供轻量级 Alpine Linux 测试容器，自动挂载项目目录

## 开发指南

### 修改工具时
1. 进入对应工具目录
2. 修改代码
3. 测试功能
4. 更新该工具的 README.md

### 添加新工具时
1. 在根目录创建新的工具目录
2. 确保工具目录包含完整的项目文件（README.md、可执行文件等）
3. 在根目录 README.md 中添加工具说明和链接
4. 保持工具独立性，不依赖其他工具

### Bash 工具规范
- 使用 `#!/usr/bin/env bash`
- 添加 `set -euo pipefail` 确保错误处理
- 可执行文件与目录同名

### Rust 工具规范
- 提供 `install.sh` 脚本简化安装
- 在 README.md 中说明 Rust 工具链安装方法
- 使用 `cargo build --release` 构建

## 常见任务

### 测试 claude-switch
```bash
cd claude-switch
./claude-switch list
./claude-switch use official
```

### 构建 codex-switch
```bash
cd codex-switch
cargo build --release
./target/release/codex-switch --help
```

### 测试 testbox
```bash
cd testbox
./testbox start
./testbox status
./testbox shell
./testbox stop
```
