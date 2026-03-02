# plugins-creater

`plugins-creater` 是一个用于生成和管理个人插件与辅助工具的工作区。

支持的插件/工具类型：
- Shell 工具（`shell-script`）
- Agent 工具（`agent-tool`）
- LLM Skill（`llm-skill`）

## 目录结构

```text
.
├── .github/
├── bin/
├── config/
├── docs/
├── examples/
├── plugins/
├── registry/
├── scripts/
├── src/
├── templates/
└── tests/
```

## 快速开始

1. 执行 `make bootstrap`
2. 执行 `make doctor`
3. 使用 `./scripts/generate.sh <type> <name>`

`<type>` 的可选值定义在 `config/plugin-types.yaml`。

## Claude 快速切换命令

- 列出预设：`./bin/custom/claude-switch list`
- 切换预设：`./bin/custom/claude-switch <profile>`
- 说明文档：`docs/guides/claude-switch.md`

## Docker 测试容器

- 启动容器：`./bin/custom/testbox start`
- 执行测试命令：`./bin/custom/testbox exec "<command>"`
- 关闭容器：`./bin/custom/testbox stop`
- 说明文档：`docs/guides/testbox.md`
