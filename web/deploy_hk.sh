#!/bin/bash

set -e

# =========================
# 配置
# =========================
SERVER="root@43.242.203.70"
SSH_PORT="23028"
#SERVER="root@119.28.114.156" # its-me.club
REMOTE_DIR="/var/www/html"
PACKAGE_NAME="dist.tar.gz"

# =========================
# 开始部署
# =========================
echo "========================="
echo "1. 前端构建"
echo "========================="
pnpm run build

echo "========================="
echo "2. 打包 dist"
echo "========================="
rm -f $PACKAGE_NAME
COPYFILE_DISABLE=1 tar -czvf $PACKAGE_NAME dist/

echo "========================="
echo "3. 上传服务器"
echo "========================="
# scp 端口参数大写 -P
scp -P $SSH_PORT $PACKAGE_NAME $SERVER:/tmp/

echo "========================="
echo "4. 服务器部署"
echo "========================="
# ssh 端口参数小写 -p
ssh -p $SSH_PORT $SERVER << EOF
set -e

echo "进入网站目录"
cd $REMOTE_DIR

echo "删除旧文件（保留 .well-known）"
find . -mindepth 1 -maxdepth 1 ! -name '.well-known' -exec rm -rf {} +

echo "解压新文件"
tar -xzvf /tmp/$PACKAGE_NAME -C /tmp/

echo "复制 dist 内容到站点目录"
cp -r /tmp/dist/* $REMOTE_DIR/

echo "清理服务器临时文件"
rm -rf /tmp/dist
rm -f /tmp/$PACKAGE_NAME

echo "远端部署完成"
EOF

echo "========================="
echo "部署成功"
echo "========================="
# 本地删除压缩包
rm -f $PACKAGE_NAME