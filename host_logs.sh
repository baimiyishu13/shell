#!/bin/bash

funct_spript_info(){
cat << EOF
    # Script Name	: host_logs.sh
    # Author:
    # Created					:30-November-2022
    # Last Modified:
    # Version					:1.0

    # Modifications:

    # Description		: 这将会收集指定的日志上打包传到文件服务器，提供输出下载 url
EOF
echo -e "\e[1;33m----------------------------------------------------------------------------------------------------------\e[0m"
}


#################################
# Start of procedures/functions #
#################################
funct_get_logs()
{
    appids=`docker ps | grep 44671 | grep 'x86_64'  | awk '{print $NF}' | awk -F"_" '{print $NF}'`  # 解码appid

    num=1
    for id in ${appids}
    do
        if [ $num == 1 ];then
            appid_first=$id
            echo -e "[$num]\e[1;31m${id}\e[0m"
        elif [ $num == 2 ];then
            appid_second=$id
            echo -e "[$num]\e[1;31m${id}\e[0m"
        fi
        let num++
    done

    # 选择 appid
    read -p "appid(1/2): " n
    case "${n}" in
    1)
        appid=${appid_first}
        ;;
    2)
        appid=${appid_second}
        ;;
    *)
        echo "error:输入1/2 选择appid"
        exit 1
    esac
    
    echo -e "\e[1;32m脚本执行中......\e[0m"

    cd /mnt/lvmdisk/.onething_data/task_${appid}/storage/cde/pcdn

    # 取文件
    for file in {cde-1010-backup.log,cde-1010.log,"./cde-cache-vod/test.log"}
    do
        if [ -e $file ];then
            package=${file}.tar.gz
            tar --warning=no-file-changed -zcf $package $file
            url=`curl -s -F upload=@$package  ${FILESERVERS}| awk -F"\"" '{print $6}'` &>/dev/null
            if [ $? -eq 0 ];then
                echo -e "\e[1;32m${url}\e[0m"
            fi
            rm -rf $package
        else
            continue
        fi
    done
}
################
# Main Program #
################

clear
sleep 1 

FILESERVERS="http://test/files"
# variable


{
    funct_spript_info
    funct_get_logs
}

cd
rm -rf $0
## End of Scriptexit