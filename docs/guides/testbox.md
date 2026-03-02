# Docker 测试容器（testbox）

`testbox` 是一个轻量 Docker 容器，只用于本地测试工具。

- 首选镜像：`plugins-creater/testbox:alpine`
- 容器名：`plugins-creater-testbox`
- 资源限制：`--cpus=0.50`、`--memory=256m`、`--pids-limit=128`
- 挂载目录：项目根目录挂载到容器 `/workspace`

平时保持关闭，测试时再开启。

首次 `start` 会尝试构建镜像；如果网络无法拉取基础镜像，会提示失败，不会使用其他业务镜像。

## 常用命令

```bash
./bin/custom/testbox start
./bin/custom/testbox status
./bin/custom/testbox exec "python3 --version"
./bin/custom/testbox stop
```

如需进入容器交互 shell：

```bash
./bin/custom/testbox shell
```
