# Sing-box Installer

Sing-box 一键安装脚本 - VLESS + Reality 单协议方案

## 特点

- ✅ **极简安全**：总共不到 300 行代码，完全透明可审计
- ✅ **单一协议**：只用 VLESS + Reality，避免复杂配置
- ✅ **官方下载**：直接从 GitHub 官方 releases 下载，启用 SSL 验证
- ✅ **无第三方依赖**：不使用任何第三方代理或 CDN
- ✅ **最小权限**：只修改必要的系统配置
- ✅ **自动防火墙**：自动配置 UFW/firewalld
- ✅ **一键更换 UUID**：定期更换凭证保护隐私

## 系统要求

- Ubuntu 20.04+ / Debian 10+
- 架构：x86_64 或 arm64
- Root 权限

## 快速安装

```bash
# 下载安装脚本
wget https://raw.githubusercontent.com/你的用户名/plugins-creater/main/sing-box-installer/install.sh

# 查看脚本内容（建议）
cat install.sh

# 执行安装
bash install.sh
```

安装完成后会输出客户端配置信息和导入链接。

## 使用方法

### 客户端连接

支持的客户端：
- **iOS/Mac**: Shadowrocket, V2Box, Stash
- **Android**: V2rayNG, NekoBox
- **Windows**: V2rayN, Clash Verge
- **Linux**: V2rayA, Clash

导入方式：
1. 复制安装脚本输出的 `vless://` 链接
2. 在客户端中选择"从剪贴板导入"

### 管理命令

```bash
# 查看服务状态
systemctl status sing-box

# 查看实时日志
journalctl -u sing-box -f

# 重启服务
systemctl restart sing-box

# 停止服务
systemctl stop sing-box

# 启动服务
systemctl start sing-box
```

### 更换 UUID

定期更换 UUID 可以提高安全性（建议每 1-2 周更换一次）：

```bash
# 下载更换脚本
wget https://raw.githubusercontent.com/你的用户名/plugins-creater/main/sing-box-installer/change-uuid.sh

# 执行更换
bash change-uuid.sh
```

脚本会自动：
- 生成新的 UUID 和密钥对
- 备份旧配置
- 重启服务
- 输出新的客户端配置

## 卸载

```bash
systemctl stop sing-box
systemctl disable sing-box
rm -rf /usr/local/bin/sing-box /etc/sing-box /etc/systemd/system/sing-box.service
systemctl daemon-reload
```

## 配置文件

- **主配置**: `/etc/sing-box/config.json`
- **服务文件**: `/etc/systemd/system/sing-box.service`
- **备份目录**: `/root/config.backup.*.json`

## 协议说明

### VLESS + Reality

- **VLESS**: 轻量级传输协议，性能优秀
- **Reality**: 新一代伪装技术，流量伪装成正常 HTTPS
- **特点**:
  - 无需域名和证书
  - 抗主动探测
  - 难以识别和封锁
  - 端到端加密

### 为什么选择单协议？

1. **简单可靠**: 减少配置复杂度，降低出错概率
2. **易于维护**: 只需关注一个协议的更新
3. **性能更好**: 避免多协议切换开销
4. **更安全**: 攻击面更小，代码更少

## 安全建议

1. **定期更换 UUID**: 使用 `change-uuid.sh` 定期更换
2. **监控日志**: 定期检查 `journalctl -u sing-box` 是否有异常连接
3. **限制访问**: 如果 IP 固定，可以配置防火墙白名单
4. **独立服务器**: 建议使用专用 VPS，不要与其他服务混用

## 与其他方案对比

| 项目 | 本方案 | fscarmen/sing-box |
|------|--------|-------------------|
| 代码行数 | ~300 行 | 4077 行 |
| 协议数量 | 1 个 | 11 个 |
| 占用端口 | 1 个 | 20 个 |
| SSL 验证 | ✅ 启用 | ❌ 禁用 |
| 第三方代理 | ❌ 无 | ✅ 5 个 |
| 统计上报 | ❌ 无 | ✅ 有 |
| 额外组件 | 无 | Nginx, Argo, jq 等 |

## 故障排查

### 服务无法启动

```bash
# 查看详细日志
journalctl -u sing-box -n 50

# 检查配置文件语法
/usr/local/bin/sing-box check -c /etc/sing-box/config.json
```

### 客户端无法连接

1. 检查防火墙是否开放 443 端口
```bash
ufw status
```

2. 检查服务是否运行
```bash
systemctl status sing-box
```

3. 检查端口是否监听
```bash
ss -tunlp | grep 443
```

4. 测试服务器网络
```bash
curl -I https://www.google.com
```

## 许可证

MIT License

## 相关链接

- [Sing-box 官方文档](https://sing-box.sagernet.org/)
- [Reality 协议说明](https://github.com/XTLS/REALITY)
