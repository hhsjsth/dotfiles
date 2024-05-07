#!/bin/zsh

# 保存为 compress_folders.zsh

# 检查是否传入了两个参数
if [ "$#" -ne 2 ]; then
  echo "Usage: $0 start_number end_number"
  exit 1
fi

# 设置nullglob选项，这样当没有匹配时，zsh会忽略该模式
setopt nullglob

# 读取参数
start=$1
end=$2

# 循环遍历指定范围内的文件夹并压缩
for i in {$start..$end}; do
  for folder in $i.*; do
    if [ -d "$folder" ]; then
      echo "Compressing $folder..."
      7z a -p$(< /home/gtr/share/Seagate/动漫/pwd) -mhe=on "${folder}.7z" "$folder"
      7z t -p$(< /home/gtr/share/Seagate/动漫/pwd) "${folder}.7z"
    else
      echo "Folder does not exist, skipping..."
    fi
  done
done

