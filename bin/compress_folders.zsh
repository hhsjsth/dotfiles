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
      7z a -mhe=on -mx0 -v10G -p$(< /home/gtr/share/Seagate/动漫/pwd) "${folder}.7z" "$folder"
      # Windows Nushell 自己测试过速度最快的命令如下 作为参考
      # 7z a -mhe=on -mx0 -mmt4 -v10G -p(open D:\8zpwd | str trim) 2025年06月12日16时06分.7z E:\B站视频\
      if [ -f "$folder.7z" ]; then
        7z t -p$(< /home/gtr/share/Seagate/动漫/pwd) "${folder}.7z" > /dev/null 2>&1 || echo "Error: ${folder}.7z is corrupted or password wrong"
      elif [ -f "$folder.7z.001" ]; then
        7z t -p$(< /home/gtr/share/Seagate/动漫/pwd) "${folder}.7z.001" > /dev/null 2>&1 || echo "Error: ${folder}.7z.001 is corrupted or password wrong"
      fi
    else
      echo "Folder $folder does not exist, skipping..."
    fi
  done
done

