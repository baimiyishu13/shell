#!/bin/bash

funct_spript_info(){
cat << EOF
    # Script Name	:ali_yum_source.sh
    # Author:
    # Created					:20-November-2022
    # Last Modified:
    # Version					:1.0

    # Modifications:

    # Description		: 此脚本配置 aliyun Centos7 yum源仓库
EOF
echo -e "\e[1;33m--------------------------------------------------------------------------------\e[0m"
}

###############################
#        开始程序/函数         #
###############################

# 程序开始


funct_congig_yum()
{
    mv /etc/yum.repos.d/CentOS-Base.repo /etc/yum.repos.d/CentOS-Base.repo.backup                       # 备份
    wget -O /etc/yum.repos.d/CentOS-Base.repo https://mirrors.aliyun.com/repo/Centos-7.repo             # 下载新的 CentOS-Base.repo 到 /etc/yum.repos.d/
    if [ $? -ne 0 ]; then
        curl -o /etc/yum.repos.d/CentOS-Base.repo https://mirrors.aliyun.com/repo/Centos-7.repo         # # 下载新的 CentOS-Base.repo 到 /etc/yum.repos.d/
    else
        echo "ERROR: 下载新的 CentOS-Base.repo 失败 "
        exit 1
    fi
    yum makecache                                                                                       # 生成缓存
}




###############################
#            主程序           #
###############################

clear
sleep 1
funct_spript_info
funct_congig_yum

## 脚本结束
echo -e "\e[1;32m执行成功\e[0m"