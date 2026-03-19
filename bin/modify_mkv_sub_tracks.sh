#!/bin/bash

# 将简体中文字幕轨道设置为默认
# MKV 轨道属性批量修改脚本
# 功能：
# 修改轨道
# 下面的 lossless-cut 相关内容不用看了, lossless-cut 不准, 使用 mkvinfo 才是准的
# 每次修改前可以使用 lossless-cut 或者 mkvinfo 查看一下轨道, lossless-cut 更方便
# 各种 flag 可以通过 lossless-cut 打开轨道信息, 点击右侧感叹号, 出现类似于下面这样的 json 文件, 根据 disposition 修改
# {
#   index: 3,
#   codec_name: 'subrip',
#   codec_long_name: 'SubRip subtitle',
#   codec_type: 'subtitle',
#   codec_tag_string: '[0][0][0][0]',
#   codec_tag: '0x0000',
#   r_frame_rate: '0/0',
#   avg_frame_rate: '0/0',
#   time_base: '1/1000',
#   start_pts: 0,
#   start_time: '0.000000',
#   duration_ts: 1502112,
#   duration: '1502.112000',
#   disposition: {
#     default: 0,
#     dub: 0,
#     original: 1,
#     comment: 0,
#     lyrics: 0,
#     karaoke: 0,
#     forced: 1,
#     hearing_impaired: 0,
#     visual_impaired: 0,
#     clean_effects: 0,
#     attached_pic: 0,
#     timed_thumbnails: 0,
#     non_diegetic: 0,
#     captions: 0,
#     descriptions: 0,
#     metadata: 0,
#     dependent: 0,
#     still_image: 0,
#     multilayer: 0,
#   },
#   tags: {
#     language: 'jpn',
#     title: 'Forced',
#     BPS: '64',
#     DURATION: '00:00:03.962000000',
#     NUMBER_OF_FRAMES: '1',
#     NUMBER_OF_BYTES: '32',
#     _STATISTICS_WRITING_APP: "mkvmerge v70.0.0 ('Caught A Lite Sneeze') 64-bit",
#     _STATISTICS_TAGS: 'BPS DURATION NUMBER_OF_FRAMES NUMBER_OF_BYTES',
#   },
# }

# 适用于当前目录下所有MKV文件

# # 检查是否安装了 mkvpropedit
# if ! command -v mkvpropedit &> /dev/null; then
#     echo "错误: mkvtoolnix 未安装，请先安装 MKVToolNix"
#     echo "在 Ubuntu/Debian 上安装: sudo apt install mkvtoolnix"
#     echo "在 macOS 上安装: brew install mkvtoolnix"
#     exit 1
# fi

# 记录处理结果
processed=0
success=0
errors=0

echo "开始处理当前目录中的 MKV 文件..."
echo "----------------------------------"

# 遍历当前目录中的所有 MKV 文件
for file in *.mkv; do
    # 检查文件是否存在（避免处理空的通配符）
    if [[ ! -f "$file" ]]; then
        continue
    fi
    
    ((processed++))
    echo "正在处理: $file"
    
    # 执行轨道属性修改
    mkvpropedit "$file" \
        --edit track:4 --set flag-default=0 \
        --edit track:4 --set flag-forced=0 \
        --edit track:5 --set flag-original=0 \
        --edit track:6 --set flag-original=0 \
        --edit track:7 --set flag-forced=0 \
        --edit track:39 --set flag-default=1 \
        --edit track:39 --set flag-forced=1 2>&1
    
    # 检查命令执行状态
    if [ $? -eq 0 ]; then
        echo "√ 修改成功"
        ((success++))
    else
        echo "× 修改失败 (可能是轨道不存在)"
        ((errors++))
    fi
    
    echo "----------------------------------"
done

# 显示最终结果
echo "处理完成!"
echo "----------------------------------"
echo "总共处理文件数: $processed"
echo "成功: $success"
echo "失败: $errors"
