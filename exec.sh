#!/bin/bash
SEND_THREAD_NUM=10
tmp_fifofile="/tmp/$$.fifo"
mkfifo "$tmp_fifofile"
exec 9<>"$tmp_fifofile"
for ((i=0;i<$SEND_THREAD_NUM;i++));do
                 echo                                                                                    
done >&9

basedir=$(dirname $0)
all_info=`cat ${basedir}/url_group.txt|egrep -v '^#|^$'`
while read line
do
        read -u 9
{
        ip_arr=($line)
        ${basedir}/check_xiaomabao_src.sh  ${ip_arr[0]} ${ip_arr[1]}
        echo >&9
} &
done <<EOF
$all_info
EOF
wait
exec 9>&- 
rm -rf $tmp_fifofile
