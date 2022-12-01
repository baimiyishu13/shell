#!/bin/bash

funct_spript_info(){
cat << EOF
    # Script Name	: host_logs.sh
    # Author:
    # Created					:30-November-2022
    # Last Modified:
    # Version					:1.0

    # Modifications:

    # Description		: 这将会收集指定的日志上传到文件服务器，提供输出下载 url
EOF
echo -e "\e[1;33m----------------------------------------------------------------------------------------------------------\e[0m"
}


#################################
# Start of procedures/functions #
#################################
funct_get_logs()
{
    appids=`docker ps | grep 44671 | grep 'x86_64'  | awk '{print $NF}' | awk -F"_" '{print $NF}'`  # 解码appid
    appid_first=`echo ${appids} | awk {'print $1'}`
    appid_second=`echo ${appids} | awk {'print $2'}`

    echo ${appids} | awk {'print $2'}
    num=0
    for id in ${appids}
    do
        echo -e "[$num]\e[1;31m${id}\e[0m"
        let num++
    done

    # 选择 appid
    read -p "appid(0/1): " n
    case "${n}" in
    0)
        appid=${appid_first}
        ;;
    1)
        appid=${appid_second}
        ;;
    *)
        echo "erro"
        exit 1
    esac
    
    echo -e "\e[1;32m执行...\e[0m"

    cd /mnt/lvmdisk/.onething_data/task_${appid}/storage/cde/pcdn
    # 取文件
    for file in {cde-1010-backup.log,cde-1010.log,"./cde-cache-vod/c"}
    do
        if [ ! -e $file ];then
        continue
        else
            url=`curl -s -F upload=@$file  ${FILESERVERS}| awk -F"\"" '{print $6}'` &>/dev/null
            if [ $? -eq 0 ];then
            echo -e "\e[1;32m${url}\e[0m"
            fi
        fi
    done

}
################
# Main Program #
################

clear
sleep 1 

FILESERVERS="http://test:9999/files/"
# variable


{
    funct_spript_info
    funct_get_logs
}

rm -rf $0
## End of Scriptexit
