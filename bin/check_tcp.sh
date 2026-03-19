#! /bin/bash

#统计不同状态 tcp 连接（除了 LISTEN ）
all_status_tcp=$(netstat -nt | awk 'NR>2 {print $6}' | sort | uniq -c)

#打印各状态 tcp 连接以及连接数
all_tcp=$(netstat -na | awk '/^tcp/ {++S[$NF]};END {for(a in S) print a, S[a]}')

#统计有哪些 IP 地址连接到了本地 80 端口（ipv4）
connect_80_ip=$(netstat -ant | grep -v 'tcp6' | awk '/:80/{split($5,ip,":");++S[ip[1]]}END{for (a in S) print S[a],a}' | sort -n)

#输出前十个连接到了本地 80 端口的 IP 地址（ipv4）
top10_connect_80_ip=$(netstat -ant | grep -v 'tcp6' | awk '/:80/{split($5,ip,":");++S[ip[1]]}END{for (a in S) print S[a],a}' | sort -rn | head -n 10)

echo -e "\e[31m不同状态(除了LISTEN) tcp 连接及连接数为：\e[0m\n${all_status_tcp}"
echo -e "\e[31m各个状态 tcp 连接以及连接数为：\e[0m\n${all_tcp}"
echo -e "\e[31m连接到本地80端口的 IP 地址及连接数为：\e[0m\n${connect_80_ip}"
echo -e "\e[31m前十个连接到本地80端口的 IP 地址及连接数为：\e[0m\n${top10_connect_80_ip}"
