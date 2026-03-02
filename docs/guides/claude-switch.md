# Claude 配置快速切换

这个工具用于快速切换 `.claude/settings.json` 里的以下字段：

- `ANTHROPIC_BASE_URL`
- `ANTHROPIC_AUTH_TOKEN`

## 1) 预配置多组账号/网关

默认配置文件：`config/claude-switch/profiles.json`

你可以直接编辑它，或者复制为本地文件：

```bash
cp config/claude-switch/profiles.json config/claude-switch/profiles.local.json
```

`profiles.local.json` 已加入 `.gitignore`，适合放真实 token。

配置格式示例：

```json
{
  "profiles": {
    "official": {
      "ANTHROPIC_BASE_URL": "https://api.anthropic.com",
      "ANTHROPIC_AUTH_TOKEN": "your-token"
    },
    "proxy-main": {
      "ANTHROPIC_BASE_URL": "https://your-proxy.example.com",
      "ANTHROPIC_AUTH_TOKEN": "your-proxy-token"
    }
  }
}
```

## 2) 列出可切换配置

```bash
./bin/custom/claude-switch list
```

## 3) 一键切换

```bash
./bin/custom/claude-switch official
```

默认会更新当前目录下的 `.claude/settings.json`。

也可以指定目标 settings 文件：

```bash
./bin/custom/claude-switch proxy-main --settings "$HOME/.claude/settings.json"
```

也可以指定配置文件：

```bash
./bin/custom/claude-switch official --config ./config/claude-switch/profiles.local.json
```
