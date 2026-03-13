# 需求记忆（仓库内）

该文件用于记录本仓库与当前协作中的稳定诉求，作为后续实现的参考基线。

## 用户主要诉求

1. 交流与文档以中文为主。
2. 区分“基础工程结构”和“用户单独明确要求实现的工具”。
3. 用户单独要求实现的可执行工具，统一放在 `bin/custom/`。
4. 后续打包安装到系统 `PATH` 时，优先基于 `bin/custom/tools.list`。
5. 已实现的历史内容可保留，不做回滚。
6. 后续执行中避免过度实现，优先严格对齐当次明确需求。
7. 安装策略采用固定目录安装，不做多版本累积目录。
8. 重复安装不覆盖已有配置文件，安装后配置可手动修改。

## 本次新增与确认

1. 已实现 Claude 配置快速切换工具：`bin/custom/claude-switch`
   - 可切换 `.claude/settings.json` 中的 `ANTHROPIC_BASE_URL`、`ANTHROPIC_AUTH_TOKEN`
   - 预设配置文件：`config/claude-switch/profiles.json`
   - 本地私密配置：`config/claude-switch/profiles.local.json`（已忽略）
2. 已实现轻量测试容器工具：`bin/custom/testbox`
   - 资源限制：`0.50 CPU / 256m Memory / pids-limit 128`
   - 容器定位：仅用于本地测试工具，平时关闭，测试时开启
   - 镜像约束：仅使用 `plugins-creater/testbox:alpine`，不使用你的业务服务镜像
   - 容器名：`plugins-creater-testbox`（当前状态：`not-created`）
   - 说明文档：`docs/guides/testbox.md`
3. `bin/custom/tools.list` 当前内容：
   - `claude-switch`
   - `testbox`
4. 已提供一键安装脚本：`scripts/install-custom.sh`
   - 固定目录安装到 `~/.local/opt/plugins-creater`
   - 命令软链到 `~/.local/bin`
   - 重复安装不覆盖已有配置文件

## 纠偏记录

1. 曾出现测试容器回退到业务镜像的实现方向，已撤销。
2. 当前 `testbox` 仅允许使用 `plugins-creater/testbox:alpine`。
3. 若镜像构建失败，将直接报错并停止，不再使用其他现有镜像。
