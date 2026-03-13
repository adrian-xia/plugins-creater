# testbox

轻量级 Docker 测试容器，用于本地工具测试。

## 功能

- 基于 Alpine Linux 的轻量级容器
- 资源限制（CPU: 0.5, Memory: 256MB, PIDs: 128）
- 自动挂载项目目录到 `/workspace`
- 空闲时自动停止

## 使用方法

```bash
# 启动容器
./testbox start

# 停止容器
./testbox stop

# 查看状态
./testbox status

# 执行命令
./testbox exec "ls -la"

# 进入 shell
./testbox shell

# 查看帮助
./testbox help
```

## Docker 配置

Dockerfile 位于 `docker/Dockerfile`，基于 Alpine Linux 构建。

## 安装

将工具链接到系统路径：

```bash
ln -s $(pwd)/testbox /usr/local/bin/testbox
```
