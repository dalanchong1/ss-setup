#!/bin/bash

echo "🔧 开始安装 Shadowsocks-libev..."

# 1. 安装 shadowsocks-libev
sudo apt update -y
sudo apt install -y shadowsocks-libev net-tools curl

# 2. 创建配置文件
sudo mkdir -p /etc/shadowsocks-libev

cat <<EOF | sudo tee /etc/shadowsocks-libev/config.json
{
  "server": "0.0.0.0",
  "server_port": 8388,
  "password": "testpass123",
  "timeout": 300,
  "method": "aes-128-gcm",
  "fast_open": false
}
EOF

# 3. 启动服务（不使用 systemd，因为 Codespaces 不支持）
echo "🚀 正在启动 Shadowsocks 服务..."
nohup ss-server -c /etc/shadowsocks-libev/config.json -v &

# 4. 获取公网 IP
IP=$(curl -s ifconfig.me)
echo ""
echo "✅ Shadowsocks 服务已启动！"
echo ""
echo "🎯 请将以下节点加入 Clash 进行测试："
echo ""
echo "proxies:"
echo "  - name: \"codespace-test\""
echo "    type: ss"
echo "    server: $IP"
echo "    port: 8388"
echo "    cipher: aes-128-gcm"
echo "    password: testpass123"
echo "    udp: true"
