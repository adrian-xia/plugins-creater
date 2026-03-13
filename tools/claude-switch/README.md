# claude-switch

用于快速切换 Claude Code 配置文件的工具。

## 功能

- 快速切换不同的 Claude 配置预设
- 支持自定义配置文件路径
- 基于 JSON 配置文件管理多个预设

## 使用方法

```bash
# 列出所有可用预设
./claude-switch list

# 切换到指定预设
./claude-switch official
./claude-switch use proxy-main

# 使用自定义配置文件
./claude-switch use official --config ./config/profiles.local.json

# 使用自定义 settings 路径
./claude-switch use official --settings /tmp/settings.json
```

## 配置文件

配置文件位于 `config/profiles.json`，格式如下：

```json
{
  "profiles": {
    "official": {
      "ANTHROPIC_BASE_URL": "https://api.anthropic.com",
      "ANTHROPIC_AUTH_TOKEN": "your-token-here"
    },
    "proxy-main": {
      "ANTHROPIC_BASE_URL": "https://proxy.example.com",
      "ANTHROPIC_AUTH_TOKEN": "your-proxy-token"
    }
  }
}
```

支持本地配置文件 `config/profiles.local.json`（优先级更高，不会被提交到 git）。

## 安装

将工具链接到系统路径：

```bash
ln -s $(pwd)/claude-switch /usr/local/bin/claude-switch
```
