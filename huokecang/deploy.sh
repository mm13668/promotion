#!/bin/bash
SERVER="root@8.163.59.237"
REMOTE_DIR="/var/www/huokecang"

scp -r index.html static "$SERVER:$REMOTE_DIR/"

if [ $? -eq 0 ]; then
  echo "Deploy successful!"
else
  echo "Deploy failed."
fi
