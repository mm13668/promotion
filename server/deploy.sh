# 交叉编译到Windows
GOOS=windows GOARCH=amd64 go build -o app-windows.exe

# 交叉编译到Mac
GOOS=darwin GOARCH=amd64 go build -o app-mac

# 交叉编译到Linux
GOOS=linux GOARCH=amd64 go build -o app-linux