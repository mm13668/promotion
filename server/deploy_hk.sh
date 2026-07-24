#!/bin/bash

# 交叉编译到Windows
# CGO_ENABLED=0 GOOS=windows GOARCH=amd64 go build -o app-windows.exe

# 交叉编译到Mac
# CGO_ENABLED=0 GOOS=darwin GOARCH=amd64 go build -o app-mac

# 交叉编译到Linux
# CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -o app-linux

set -e

# =========================
# 配置
# =========================
SERVER="root@43.242.203.70"
SSH_PORT="23028"
REMOTE_DIR="/var/www"
APP_NAME="app-linux"
PACKAGE_NAME="server.tar.gz"
UPLOADS_PACKAGE_NAME="server-uploads.tar.gz"

# =========================
# 开始部署
# =========================
echo "========================="
echo "1. 编译 Linux 服务"
echo "========================="
CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -o $APP_NAME

echo "========================="
echo "2. 打包程序"
echo "========================="
rm -f $PACKAGE_NAME
tar -czvf $PACKAGE_NAME $APP_NAME

echo "========================="
echo "3. 打包模板、插件、临时文件"
echo "========================="
rm -f $UPLOADS_PACKAGE_NAME
tar -czvf $UPLOADS_PACKAGE_NAME -C "$(dirname "$0")/uploads" plugins template news/temp

echo "========================="
echo "4. 上传文件到服务器 /tmp"
echo "========================="
# scp 使用大写 -P 指定端口
scp -P $SSH_PORT $PACKAGE_NAME $SERVER:/tmp/
scp -P $SSH_PORT $UPLOADS_PACKAGE_NAME $SERVER:/tmp/

echo "========================="
echo "5. 远程部署执行"
echo "========================="
# ssh 使用小写 -p 指定端口
ssh -T -p $SSH_PORT $SERVER << EOF
set -e
cd /tmp

echo "解压程序包"
tar -xzvf $PACKAGE_NAME

echo "替换服务二进制"
mv -f $APP_NAME $REMOTE_DIR/

echo "赋予执行权限"
chmod +x $REMOTE_DIR/$APP_NAME

echo "清理旧插件/模板/临时目录"
rm -rf $REMOTE_DIR/uploads/plugins $REMOTE_DIR/uploads/template $REMOTE_DIR/uploads/news/temp

echo "解压静态资源包"
mkdir -p $REMOTE_DIR/uploads
tar -xzvf $UPLOADS_PACKAGE_NAME -C $REMOTE_DIR/uploads

echo "清理服务器临时压缩包"
rm -f $PACKAGE_NAME $UPLOADS_PACKAGE_NAME

echo "重载systemd并重启服务"
systemctl daemon-reload
systemctl restart app

echo "远端部署步骤全部完成"
EOF

echo "========================="
echo "本地清理压缩包，部署结束"
echo "========================="
rm -f $PACKAGE_NAME $UPLOADS_PACKAGE_NAME
echo "✅ 部署成功！"