#!/bin/bash

#物理内存使用量
mem_used=$(free -m | grep Mem | awk '{print$3}')

#物理内存总量
mem_total=$(free -m | grep Mem | awk '{print$2}')

#cpu核数
cpu_num=$(lscpu | grep 'CPU(s)' | awk 'NR==1 {print$2}')

#平均负载
load_average=$(uptime | awk -F : '{print$5}')

#用户态的CPU使用率
cpu_us=$(top -d 1 -n 1 | grep Cpu | awk -F',' '{print $1}' | awk '{print $(NF-1)}')

#内核态的CPU使用率
cpu_sys=$(top -d 1 -n 1 | grep Cpu | awk -F',' '{print $2}' | awk '{print $(NF-1)}')

#等待I/O的CPU使用率
cpu_wa=$(top -d 1 -n 1 | grep Cpu | awk -F',' '{print $5}' | awk '{print $(NF-1)}')

#处理硬中断的CPU使用率
cpu_hi=$(top -d 1 -n 1 | grep Cpu | awk -F',' '{print $6}' | awk '{print $(NF-1)}')

#处理软中断的CPU使用率
cpu_si=$(top -d 1 -n 1 | grep Cpu | awk -F',' '{print $7}' | awk '{print $(NF-1)}')

echo -e "物理内存使用量(M)为：${mem_used}"
echo -e "物理内存总量(M)为：${mem_total}"
echo -e "cpu核数为：${cpu_num}"
echo -e "平均负载为：${load_average}"
echo -e "用户态的CPU使用率为：${cpu_us}"
echo -e "内核态的CPU使用率为：${cpu_sys}"
echo -e "等待I/O的CPU使用率为：${cpu_wa}"
echo -e "处理硬中断的CPU使用率为：${cpu_hi}"
echo -e "处理软中断的CPU使用率为：${cpu_si}"
