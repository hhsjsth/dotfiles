#!/bin/bash

cd ~

# code-tunnel tunnel service uninstall

# 定义下载链接和目标文件名
DOWNLOAD_URL="https://code.visualstudio.com/sha/download?build=stable&os=linux-x64"
TARGET_FILE="code-stable-x64.tar.gz"

# 使用 wget 下载文件，如果文件已存在则覆盖
echo "正在下载 $TARGET_FILE..."
curl -L "$DOWNLOAD_URL" -o"$TARGET_FILE"

# 检查下载是否成功
if [ $? -eq 0 ]; then
    echo "下载完成。"

    # 解压缩文件并覆盖现有文件
    echo "正在解压 $TARGET_FILE..."
    tar -xzf "$TARGET_FILE" --overwrite

    # 检查解压是否成功
    if [ $? -eq 0 ]; then
        echo "解压完成。"
    else
        echo "解压失败。"
        exit 1
    fi
else
    echo "下载失败。"
    exit 1
fi

# 清理：删除下载的 .tar.gz 文件（可选）
# rm -f "$TARGET_FILE"
# echo "临时文件已清理。"

echo "所有操作已完成。"

# code-tunnel tunnel service install
# sudo loginctl enable-linger $USER
