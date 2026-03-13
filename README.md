# 工具集合

个人开发工具集合，每个工具都是独立完整的项目，可单独使用。

## 工具列表

### [claude-switch](./claude-switch/)
Claude Code 配置快速切换工具

**功能：**
- 快速切换不同的 Claude 配置预设
- 支持自定义配置文件路径
- 基于 JSON 配置文件管理多个预设

**技术栈：** Bash

**快速开始：**
```bash
cd claude-switch
./claude-switch list
./claude-switch use official
```

---

### [codex-switch](./codex-switch/)
Codex 认证配置切换工具

**功能：**
- 快速切换不同的 codex 认证配置
- 支持注册和管理多个配置源
- 自动补全支持（bash/zsh/fish）

**技术栈：** Rust

**快速开始：**
```bash
cd codex-switch
./install.sh
codex-switch register official
codex-switch official
```

---

### [testbox](./testbox/)
Docker 测试容器管理工具

**功能：**
- 基于 Alpine Linux 的轻量级测试容器
- 资源限制（CPU: 0.5, Memory: 256MB）
- 自动挂载项目目录到 `/workspace`
- 空闲时自动停止

**技术栈：** Bash + Docker

**快速开始：**
```bash
cd testbox
./testbox start
./testbox shell
```

---

## 安装

每个工具都可以独立安装，详见各工具目录下的 README.md。

通用安装方式（将工具链接到系统路径）：

```bash
# claude-switch
ln -s $(pwd)/claude-switch/claude-switch /usr/local/bin/claude-switch

# codex-switch（需要先构建）
cd codex-switch && ./install.sh

# testbox
ln -s $(pwd)/testbox/testbox /usr/local/bin/testbox
```

## 目录结构

```
.
├── claude-switch/      # Claude Code 配置切换工具
│   ├── README.md
│   ├── claude-switch
│   └── config/
├── codex-switch/       # Codex 认证配置切换工具
│   ├── README.md
│   ├── Cargo.toml
│   ├── src/
│   └── install.sh
└── testbox/            # Docker 测试容器管理工具
    ├── README.md
    ├── testbox
    └── docker/
```

## 设计原则

- **独立完整**：每个工具目录都是一个完整的项目，可以单独拿出来使用
- **互不干扰**：工具之间没有依赖关系，可以独立开发和维护
- **单一职责**：每个工具专注于解决一个特定问题
