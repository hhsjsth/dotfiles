#查找系统中任何用户都有写权限的文件（目录），并存放到/tmp/anynone_write.txt
find / -type f -perm -2 -o -perm -20 -exec echo {} \; >>/tmp/anynone_write.txt

#查找系统中所有含 's' 位权限的程序，并存放到/tmp/s_permission.txt
find / -type f -perm -4000 -o -perm -2000 -print -exec echo {} \; >>/tmp/s_permission.txt

#查找系统中没有属主以及属组的文件，并存放到/tmp/none.txt
find / -nouser -o -nogroup -exec echo {} \; >>/tmp/none.txt
