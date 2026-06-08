#!/bin/bash

# 交叉编译到Windows
# GOOS=windows GOARCH=amd64 go build -o app-windows.exe

# 交叉编译到Mac
# GOOS=darwin GOARCH=amd64 go build -o app-mac

# 交叉编译到Linux
# GOOS=linux GOARCH=amd64 go build -o app-linux


set -e

# =========================
# 配置
# =========================

# SERVER="root@8.163.59.237"
SERVER="root@119.28.114.156" # its-me.club

REMOTE_DIR="/var/www"

APP_NAME="app-linux"

PACKAGE_NAME="server.tar.gz"

# =========================
# 开始部署
# =========================

echo "========================="
echo "1. 编译 Linux 服务"
echo "========================="

CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -o $APP_NAME

echo "========================="
echo "2. 打包"
echo "========================="

rm -f $PACKAGE_NAME

tar -czvf $PACKAGE_NAME $APP_NAME

echo "========================="
echo "3. 打包模板和插件"
echo "========================="

UPLOADS_PACKAGE_NAME="server-uploads.tar.gz"

rm -f $UPLOADS_PACKAGE_NAME

tar -czvf $UPLOADS_PACKAGE_NAME -C "$(dirname "$0")/uploads" plugins template

echo "========================="
echo "4. 上传服务器"
echo "========================="

scp $PACKAGE_NAME $SERVER:/tmp/
scp $UPLOADS_PACKAGE_NAME $SERVER:/tmp/

echo "========================="
echo "5. 开始部署"
echo "========================="

ssh -T $SERVER << EOF

set -e

cd /tmp

echo "解压服务文件"

tar -xzvf $PACKAGE_NAME

echo "移动到目标目录"

mv -f $APP_NAME $REMOTE_DIR/

echo "添加执行权限"

chmod +x $REMOTE_DIR/$APP_NAME

echo "清理旧的模板和插件"

rm -rf $REMOTE_DIR/uploads/plugins $REMOTE_DIR/uploads/template

echo "解压模板和插件"

mkdir -p $REMOTE_DIR/uploads

tar -xzvf $UPLOADS_PACKAGE_NAME -C $REMOTE_DIR/uploads

echo "清理临时文件"

rm -f $PACKAGE_NAME $UPLOADS_PACKAGE_NAME

echo "重启服务"
systemctl daemon-reload
systemctl restart app

echo "部署完成"

EOF

echo "========================="
echo "部署成功"
echo "========================="

rm -f $PACKAGE_NAME $UPLOADS_PACKAGE_NAME