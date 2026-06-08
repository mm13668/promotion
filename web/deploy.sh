#!/bin/bash

set -e

# =========================
# 配置
# =========================

# SERVER="root@8.163.59.237"
SERVER="root@119.28.114.156" # its-me.club

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

scp $PACKAGE_NAME $SERVER:/tmp/

echo "========================="
echo "4. 服务器部署"
echo "========================="

ssh $SERVER << EOF

set -e

echo "进入网站目录"

cd $REMOTE_DIR

echo "删除旧文件"

find . -mindepth 1 -maxdepth 1 ! -name '.well-known' -exec rm -rf {} +

echo "解压新文件"

tar -xzvf /tmp/$PACKAGE_NAME -C /tmp/

echo "复制 dist 内容"

cp -r /tmp/dist/* $REMOTE_DIR/

echo "清理临时文件"

rm -rf /tmp/dist
rm -f /tmp/$PACKAGE_NAME

echo "部署完成"

EOF

echo "========================="
echo "部署成功"
echo "========================="

rm -f $PACKAGE_NAME