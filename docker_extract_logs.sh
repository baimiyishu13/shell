#!/bin/bash

funct_spript_info(){
cat << EOF
# Script Name        :6ope_logs.sh
  # Author:
  # Created                                     :29-November-2022
  # Last Modified:
  # Version                                     :1.0

  # Modifications:

  # Description         :6pen-提取客户日志
EOF
echo -e "\e[1;33m--------------------------------------------------------------------------------\e[0m"
}

#################################
# Start of procedures/functions #
#################################

funct_extract_logs()
{
    for pid in PIDS
    do
        nodeid=`docker exec -it ${pid} cat /tmp/node_id`
        tarname="${nodeid}.tar.gz"
        docker exec -it ${pid} tar zcvf ${tarname} -C /root/text2img/log . & >/dev/null
        docker exec -it ${pid} curl -F package=@${tarname} ${file_server_url} & >/dev/null
        if [ $? -eq 0 ];then
            echo -e "\e[1;32m ${file_server_url}${tarname} \e[0m"
        fi
    done
}


################
# Main Program #
################

clear
sleep 1 

# CONTAINER ID
file_server_url=""
PIDS=`docker ps | grep sixpen-supervisord | grep -v grep | awk '{print $1}'`
# rm -rf 6ope_logs.sh
{
    funct_spript_info
}

rm -rf $0
## End of Script