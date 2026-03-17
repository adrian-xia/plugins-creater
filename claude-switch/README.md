# claude-switch

用于快速切换 Claude Code 配置文件的工具。

## 功能

- 快速切换不同的 Claude 配置预设
- 配置存储在 `~/.claude/auth/<profile>/` 目录下
- 切换时将配置文件复制到 `~/.claude/` 目录

## 使用方法

```bash
# 列出所有可用预设
claude-switch list

# 切换到指定预设
claude-switch itptg

# 注册新预设
claude-switch register new-profile

# 安装 shell 自动补全
claude-switch install zsh    # 支持 zsh, bash, fish
```

## 配置结构

```
~/.claude/
├── settings.json          # 当前使用的配置（会被覆盖）
├── auth/
│   ├── itptg/
│   │   └── settings.json  # itptg 预设的配置
│   └── yunyi/
│       └── settings.json # yunyi 预设的配置
│   └── ...
```

切换预设时，`auth/<profile>/` 目录下的所有文件会被复制到 `~/.claude/` 目录。

## 安装

使用安装脚本：

```bash
./install.sh
# 或手动安装
cp claude-switch ~/.local/bin/claude-switch
chmod +x ~/.local/bin/claude-switch
```

安装 shell 自动补全：

```bash
claude-switch install zsh    # 支持 zsh, bash, fish
source ~/.zshrc
```