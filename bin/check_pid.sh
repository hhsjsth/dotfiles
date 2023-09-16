#! /bin/bash

read -p "请输入要查询的PID: " P

n=$(ps -aux | awk '$2~/^'${P}'$/{print $0}' | wc -l)

if [ $n -eq 0 ]; then
	echo "该PID不存在！！"
	exit
fi
echo -e "\e[32m--------------------------------\e[0m"
echo "进程PID: ${P}"
echo "进程命令：$(ps -aux | awk '$2~/^'$P'$/{for (i=11;i<=NF;i++) printf("%s ",$i)}')"
echo "进程所属用户: $(ps -aux | awk '$2~/^'$P'$/{print $1}')"
echo "CPU占用率：$(ps -aux | awk '$2~/^'$P'$/{print $3}')%"
echo "内存占用率：$(ps -aux | awk '$2~/^'$P'$/{print $4}')%"
echo "进程开始运行的时间：$(ps -aux | awk '$2~/^'$P'$/{print $9}')"
echo "进程运行的时间：$(ps -aux | awk '$2~/^'$P'$/{print $10}')"
echo "进程状态：$(ps -aux | awk '$2~/^'$P'$/{print $8}')"
echo "进程虚拟内存：$(ps -aux | awk '$2~/^'$P'$/{print $5}')"
echo "进程共享内存：$(ps -aux | awk '$2~/^'$P'$/{print $6}')"
echo -e "\e[32m--------------------------------\e[0m"
