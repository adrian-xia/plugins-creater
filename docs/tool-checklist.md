# 单独要求工具清单

本清单只记录你“单独明确要求我实现”的工具，并且这些工具的可执行文件统一放在 `bin/custom/`，用于后续打包安装到系统 `PATH`。

- [x] Claude 配置快速切换工具（`bin/custom/claude-switch`）
  - 用途：按 profile 一键切换 `.claude/settings.json` 中的 `ANTHROPIC_BASE_URL` 和 `ANTHROPIC_AUTH_TOKEN`
  - 预设配置：`config/claude-switch/profiles.json`
  - 本地敏感配置：`config/claude-switch/profiles.local.json`（已在 `.gitignore` 中忽略）
  - 可执行清单文件：`bin/custom/tools.list`
  - 常用命令：`./bin/custom/claude-switch list`、`./bin/custom/claude-switch <profile>`

- [x] 轻量 Docker 测试容器工具（`bin/custom/testbox`）
  - 用途：专用于本地测试工具，平时关闭，测试时启动
  - 资源限制：`0.50 CPU`、`256m 内存`、`pids-limit 128`
  - 镜像策略：仅使用 `plugins-creater/testbox:alpine`
  - 常用命令：`./bin/custom/testbox start`、`./bin/custom/testbox exec "<command>"`、`./bin/custom/testbox stop`
  - 说明文档：`docs/guides/testbox.md`
