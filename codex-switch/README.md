# codex-switch

用于切换 codex 认证配置的命令行工具（Bash 实现）。

## 功能

- 快速切换不同的 codex 认证配置
- 支持注册和管理多个配置源
- 自动补全支持（bash/zsh/fish）

## 使用方法

```bash
# 列出所有可用配置源
codex-switch list

# 切换到指定配置源
codex-switch official

# 注册新配置源
codex-switch register new-profile

# 安装 shell 自动补全
codex-switch install zsh    # 支持 zsh, bash, fish
```

## 目录结构

```
~/.codex/
├── auth.json          # 当前使用的认证文件（会被覆盖）
├── config.toml        # 当前使用的配置文件（会被覆盖）
└── auth/
    ├── official/      # official 配置源
    │   ├── auth.json
    │   └── config.toml
    ├── personal/      # personal 配置源
    │   └── auth.json
    └── ...
```

切换配置源时，`auth/<source>/` 目录下的 `auth.json` 和 `config.toml` 会被复制到 `~/.codex/` 目录。

## 安装

使用安装脚本：

```bash
./install.sh
# 或手动安装
cp codex-switch ~/.local/bin/codex-switch
chmod +x ~/.local/bin/codex-switch
```

安装 shell 自动补全：

```bash
codex-switch install zsh    # 支持 zsh, bash, fish
source ~/.zshrc
```