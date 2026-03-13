# Tools 目录

本目录包含项目的自定义工具集合。

## 工具列表

- **claude-switch**: Claude Code 配置快速切换工具
- **codex-switch**: Codex 认证配置切换工具（Rust 实现）
- **testbox**: Docker 测试容器管理工具

## 使用方法

详见项目根目录的 `docs/guides/tools-management.md`

## 目录结构

每个工具都遵循以下结构：

```
tool-name/
├── tool-name       # 可执行文件（必需，与目录同名）
├── README.md       # 工具说明文档
├── config/         # 配置文件（可选）
└── ...             # 其他资源文件
```

## 安装

```bash
# 安装所有工具
make install-tools

# 安装指定工具
make install-tools tool=claude-switch
```
