# codex-switch

用于切换 codex 认证配置的命令行工具。

## 功能

- 快速切换不同的 codex 认证配置
- 支持注册和管理多个配置源
- 自动补全支持（bash/zsh/fish）
- 简单的安装和使用

## 安装

### 前置要求

需要先安装 Rust 工具链：

```bash
# macOS/Linux
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

# 安装完成后，重新加载环境变量
source $HOME/.cargo/env
```

### 构建和安装

```bash
# 方法 1: 使用安装脚本（推荐）
./install.sh

# 方法 2: 手动安装
cargo build --release
sudo cp target/release/codex-switch /usr/local/bin/

# 方法 3: 使用 cargo install
cargo install --path .
```

## 快速开始

完整的使用流程：

```bash
# 1. 安装 Rust（如果还没安装）
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
source $HOME/.cargo/env

# 2. 构建并安装工具
cargo build --release
sudo cp target/release/codex-switch /usr/local/bin/

# 3. 注册 official 配置源
codex-switch register official

# 4. 将配置文件放入对应目录
cp /path/to/your/auth.json ~/.codex/auth/official/auth.json
cp /path/to/your/config.toml ~/.codex/auth/official/config.toml

# 5. 切换到 official 配置
codex-switch official

# 6. 安装自动补全（可选）
codex-switch install zsh >> ~/.zshrc
source ~/.zshrc
```

## 使用方法

### 1. 注册配置源

```bash
# 注册一个名为 "official" 的配置源
codex-switch register official

# 这会创建 ~/.codex/auth/official/ 目录
# 将你的 auth.json 和/或 config.toml 放入该目录
```

### 2. 切换配置

```bash
# 切换到 official 配置
codex-switch official

# 这会将 ~/.codex/auth/official/ 下的文件复制到 ~/.codex/
```

### 3. 查看所有配置源

```bash
codex-switch list
```

### 4. 安装自动补全

```bash
# 为 zsh 生成补全脚本
codex-switch install zsh >> ~/.zshrc
source ~/.zshrc

# 为 bash 生成补全脚本
codex-switch install bash >> ~/.bashrc
source ~/.bashrc

# 为 fish 生成补全脚本
codex-switch install fish
# 然后手动将输出添加到 ~/.config/fish/completions/codex-switch.fish
```

## 目录结构

```
~/.codex/
├── auth.json          # 当前使用的认证文件
├── config.toml        # 当前使用的配置文件
└── auth/
    ├── official/      # official 配置源
    │   ├── auth.json
    │   └── config.toml
    ├── personal/      # personal 配置源
    │   ├── auth.json
    │   └── config.toml
    └── ...
```

## 示例工作流

```bash
# 1. 注册 official 配置
codex-switch register official

# 2. 将认证文件放入配置目录
cp /path/to/official-auth.json ~/.codex/auth/official/auth.json
cp /path/to/official-config.toml ~/.codex/auth/official/config.toml

# 3. 注册 personal 配置
codex-switch register personal
cp /path/to/personal-auth.json ~/.codex/auth/personal/auth.json

# 4. 切换到 official
codex-switch official

# 5. 切换到 personal
codex-switch personal

# 6. 查看所有配置
codex-switch list
```

## 自动补全

安装自动补全后，你可以使用 Tab 键来补全配置源名称：

```bash
codex-switch <Tab>
# 显示: official personal ...
```
