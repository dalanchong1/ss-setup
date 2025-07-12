#!/bin/bash

# 安装 Shadowsocks-libev
sudo apt update
sudo apt install -y shadowsocks-libev

# 创建配置文件
cat > /etc/shadowsocks-libev/config.json <<EOF
{
    "server":"0.0.0.0",
    "server_port":8388,
    "password":"bC1jwiPEJk3Fkrg49S+DAg==",
    "timeout":60,
    "method":"aes-128-gcm",
    "fast_open":true,
    "reuse_port":true,
    "no_delay":true
}
EOF

# 启动并设置为开机自启
systemctl restart shadowsocks-libev
systemctl enable shadowsocks-libev

# 开放端口（如已安装 ufw）
if command -v ufw &> /dev/null; then
  ufw allow 8388/tcp
  ufw allow 8388/udp
fi

echo "✅ Shadowsocks 安装完成，端口: 8388，密码: bC1jwiPEJk3Fkrg49S+DAg==，加密方式: aes-128-gcm"
