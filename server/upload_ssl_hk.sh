#!/bin/bash

set -e

# =========================
# 配置
# =========================
SERVER="root@43.242.203.70"
SSH_PORT="23028"
REMOTE_DIR="/etc/nginx/ssl"
PACKAGE_NAME="ssl.tar.gz"

# =========================
# 开始上传
# =========================
echo "========================="
echo "1. 打包 SSL 证书"
echo "========================="

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
rm -f $PACKAGE_NAME
tar -czvf $PACKAGE_NAME -C "$SCRIPT_DIR/ssl" .

echo "========================="
echo "2. 上传服务器"
echo "========================="
# scp 端口参数大写 -P
scp -P $SSH_PORT $PACKAGE_NAME $SERVER:/tmp/

echo "========================="
echo "3. 部署到 $REMOTE_DIR"
echo "========================="
# ssh 端口参数小写 -p
ssh -T -p $SSH_PORT $SERVER << EOF

set -e

echo "创建目标目录"
sudo mkdir -p $REMOTE_DIR

echo "解压证书文件"
sudo tar -xzvf /tmp/$PACKAGE_NAME -C $REMOTE_DIR

echo "清理临时文件"
rm -f /tmp/$PACKAGE_NAME

echo "设置权限"
sudo chown -R root:root $REMOTE_DIR
sudo chmod -R 644 $REMOTE_DIR
sudo find $REMOTE_DIR -type d -exec chmod 755 {} \;

echo "上传完成"

EOF

echo "========================="
echo "4. 清理本地临时文件"
echo "========================="
rm -f $PACKAGE_NAME

echo "========================="
echo "SSL 证书上传成功"
echo "========================="