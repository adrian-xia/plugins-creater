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
├── tests/
└── tools/          # 自定义工具集合
    ├── claude-switch/
    ├── codex-switch/
    └── testbox/
```

## 快速开始

1. 执行 `make bootstrap`
2. 执行 `make doctor`
3. 使用 `./scripts/generate.sh <type> <name>`

`<type>` 的可选值定义在 `config/plugin-types.yaml`。

## 工具管理

### 列出所有工具

```bash
make list-tools
```

### 安装工具

```bash
# 安装所有工具
make install-tools

# 安装指定工具
make install-tools tool=claude-switch
```

### 可用工具

- **claude-switch**: Claude Code 配置快速切换工具
- **codex-switch**: Codex 认证配置切换工具（Rust 实现）
- **testbox**: Docker 测试容器管理工具

详细说明请查看各工具目录下的 README.md 文件。
