#!/usr/bin/env bash
set -euo pipefail

# 一键更换 UUID 并重启 sing-box

CONFIG_FILE="/etc/sing-box/config.json"
INSTALL_DIR="/usr/local/bin"

# 颜色输出
info() { echo -e "\033[32m[INFO]\033[0m $*"; }
warning() { echo -e "\033[33m[WARN]\033[0m $*"; }

# 检查 root 权限
[[ $EUID -ne 0 ]] && { echo "请使用 root 权限运行"; exit 1; }

# 检查配置文件
[[ ! -f "$CONFIG_FILE" ]] && { echo "配置文件不存在: $CONFIG_FILE"; exit 1; }

# 获取服务器 IP 和端口
SERVER_IP=$(ip addr show | grep 'inet ' | grep -v '127.0.0.1' | awk '{print $2}' | cut -d/ -f1 | head -1)
PORT=$(grep -oP '"listen_port":\s*\K\d+' "$CONFIG_FILE")

# 生成新的 UUID
NEW_UUID=$(cat /proc/sys/kernel/random/uuid)

# 读取当前配置
PRIVATE_KEY=$(grep -oP '"private_key":\s*"\K[^"]+' "$CONFIG_FILE")
SHORT_ID=$(grep -A1 '"short_id"' "$CONFIG_FILE" | grep -oP '"\K[0-9a-f]+(?=")')

# 生成新的密钥对
KEYS=$($INSTALL_DIR/sing-box generate reality-keypair)
NEW_PRIVATE_KEY=$(echo "$KEYS" | grep "PrivateKey:" | awk '{print $2}')
PUBLIC_KEY=$(echo "$KEYS" | grep "PublicKey:" | awk '{print $2}')

# 备份原配置
BACKUP_FILE="/root/config.backup.$(date +%Y%m%d_%H%M%S).json"
cp "$CONFIG_FILE" "$BACKUP_FILE"
info "已备份配置到: $BACKUP_FILE"

# 获取旧 UUID
OLD_UUID=$(grep -oP '"uuid":\s*"\K[^"]+' "$CONFIG_FILE" | head -1)

# 替换 UUID 和密钥
sed -i "s/\"uuid\": \"$OLD_UUID\"/\"uuid\": \"$NEW_UUID\"/" "$CONFIG_FILE"
sed -i "s/\"private_key\": \"$PRIVATE_KEY\"/\"private_key\": \"$NEW_PRIVATE_KEY\"/" "$CONFIG_FILE"

# 重启服务
info "重启 sing-box 服务..."
systemctl restart sing-box
sleep 2

# 检查服务状态
if systemctl is-active --quiet sing-box; then
    info "✓ UUID 更换成功！"
    echo ""
    echo "=========================================="
    echo "新的客户端配置"
    echo "=========================================="
    echo "旧 UUID: $OLD_UUID"
    echo "新 UUID: $NEW_UUID"
    echo "新 Public Key: $PUBLIC_KEY"
    echo "Short ID: $SHORT_ID (未变)"
    echo ""
    echo "Shadowrocket/V2rayN/Nekobox 导入链接:"
    echo "vless://${NEW_UUID}@${SERVER_IP}:${PORT}?encryption=none&flow=xtls-rprx-vision&security=reality&sni=www.microsoft.com&fp=chrome&pbk=${PUBLIC_KEY}&sid=${SHORT_ID}&type=tcp&headerType=none#Sing-box-Reality"
    echo "=========================================="
else
    warning "✗ 服务启动失败，正在恢复备份..."
    cp "$BACKUP_FILE" "$CONFIG_FILE"
    systemctl restart sing-box
    echo "已恢复到备份配置"
    exit 1
fi
