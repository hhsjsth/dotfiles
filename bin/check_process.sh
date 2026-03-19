#! /bin/bash

read -p "请输入要查询的进程名：" NAME


N=`ps -aux | grep $NAME | grep -v grep | wc -l` ##统计进程总数

if [ $N -le 0 ];then
  echo "该进程名没有运行！"
fi
i=1
while [ $N -gt 0 ]
do
  echo -e "\e[32m***************************************************************\e[0m"
  echo "进程PID: $(ps -aux | grep $NAME | grep -v grep | awk 'NR=='$i'{print $0}'| awk '{print $2}')"
  echo "进程命令：$(ps -aux | grep $NAME | grep -v grep | awk 'NR=='$i'{print $0}'| awk '{for (j=11;j<=NF;j++) printf("%s ",$j)}')"
  echo "进程所属用户: $(ps -aux | grep $NAME | grep -v grep | awk 'NR=='$i'{print $0}'| awk '{print $1}')"
  echo "CPU占用率：$(ps -aux | grep $NAME | grep -v grep | awk 'NR=='$i'{print $0}'| awk '{print $3}')%"
  echo "内存占用率：$(ps -aux | grep $NAME | grep -v grep | awk 'NR=='$i'{print $0}'| awk '{print $4}')%"
  echo "进程开始运行的时间：$(ps -aux | grep $NAME | grep -v grep | awk 'NR=='$i'{print $0}'| awk '{print $9}')"
  echo "进程运行的时间：$(ps -aux | grep $NAME | grep -v grep | awk 'NR=='$i'{print $0}'| awk '{print $10}')"
  echo "进程状态：$(ps -aux | grep $NAME | grep -v grep | awk 'NR=='$i'{print $0}'| awk '{print $8}')"
  echo "进程虚拟内存：$(ps -aux | grep $NAME | grep -v grep | awk 'NR=='$i'{print $0}'| awk '{print $5}')"
  echo "进程共享内存：$(ps -aux | grep $NAME | grep -v grep | awk 'NR=='$i'{print $0}'| awk '{print $6}')"
  echo -e "\e[32m***************************************************************\e[0m"
  let N-- i++
done
