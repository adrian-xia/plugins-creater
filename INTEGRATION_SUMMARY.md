# 工具集成与清理总结

已成功将 codex-switch 功能集成到项目中，重新组织了工具目录结构，并清理了所有旧文件。

## 完成的工作

### 1. 创建统一的工具目录结构

```
tools/
├── claude-switch/      # Claude Code 配置切换工具
├── codex-switch/       # Codex 认证配置切换工具（Rust）
└── testbox/            # Docker 测试容器管理工具
```

### 2. 集成的工具

- **claude-switch**: 从 `bin/custom/` 迁移到 `tools/claude-switch/`
- **codex-switch**: 从 `/Users/adrian/Developer/Codes/tools/codex-switch` 完整集成
- **testbox**: 从 `bin/custom/` 迁移到 `tools/testbox/`

### 3. 清理的旧文件

已删除：
- `bin/custom/` 整个目录
- `config/claude-switch/` 目录
- `docker/testbox/` 目录
- `scripts/install-custom.sh`
- `docs/guides/claude-switch.md`
- `docs/guides/testbox.md`
- `docs/guides/install-custom-tools.md`

### 4. 更新的文件

- `README.md`: 更新项目说明，添加工具管理部分
- `Makefile`: 添加 `list-tools` 和 `install-tools` 命令
- `.gitignore`: 更新工具相关的忽略规则
- `scripts/install-tools.sh`: 新增工具安装脚本（支持 Rust 工具）
- `docs/guides/tools-management.md`: 新增工具管理指南

### 5. 每个工具的结构

```
tool-name/
├── tool-name       # 可执行文件（与目录同名）
├── README.md       # 工具说明文档
├── config/         # 配置文件（可选）
└── ...             # 其他资源文件
```

## 使用方法

```bash
# 列出所有工具
make list-tools

# 安装所有工具
make install-tools

# 安装指定工具
make install-tools tool=claude-switch
```

## codex-switch 特殊说明

codex-switch 是 Rust 实现的工具，需要先构建：

```bash
# 安装 Rust（如果未安装）
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
source $HOME/.cargo/env

# 构建 codex-switch
cd tools/codex-switch
cargo build --release

# 或使用提供的安装脚本
./install.sh
```

## 目录结构对比

### 旧结构（已删除）
```
bin/custom/
  ├── claude-switch
  ├── testbox
  ├── README.md
  └── tools.list
config/claude-switch/
  └── profiles.json
docker/testbox/
  └── Dockerfile
```

### 新结构
```
tools/
  ├── claude-switch/
  │   ├── claude-switch
  │   ├── config/profiles.json
  │   └── README.md
  ├── codex-switch/
  │   ├── src/main.rs
  │   ├── Cargo.toml
  │   ├── install.sh
  │   └── README.md
  └── testbox/
      ├── testbox
      ├── docker/Dockerfile
      └── README.md
```

## Git 状态

Git 自动识别出文件移动：
- `bin/custom/claude-switch` → `tools/claude-switch/claude-switch`
- `bin/custom/testbox` → `tools/testbox/testbox`
- `config/claude-switch/profiles.json` → `tools/claude-switch/config/profiles.json`
- `docker/testbox/Dockerfile` → `tools/testbox/docker/Dockerfile`
