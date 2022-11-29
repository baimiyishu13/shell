#!/bin/bash

funct_spript_info(){
cat << EOF
   # Script Name        :batch_file_rename.sh
  # Author:
  # Created                                     :20-November-2022
  # Last Modified:
  # Version                                     :1.0

  # Modifications:

  # Description         :这会将所有文件从一个扩展名批量重命名为另一个扩展
EOF
}


################################
#        开始程序/函数         #
################################


funct_check_params()

{
	if [ ! ${LENGHT} -eq 3 ]; then								# 检查有 3 个参数传递给脚本，如果没有显示帮助
		echo "Usage: $0 directory *.old_extension *.new_extension"
		exit 1
	fi

}

funct_batch_rename()
{
	old_ext_awk=`echo ${OLD_EXT} | awk -F"." '{print $NF}'`		# awk 截取扩展名
	new_ext_awk=`echo ${NEW_EXT} | awk -F"." '{print $NF}'`		# awk 截取扩展名
	
	#这将执行重命名
	
	for file in `ls ${WORK_DIR}/*${OLD_EXT}`
    do
        mv $file `echo $file | sed 's/\(.*\.\)'$old_ext_awk'/\1'$new_ext_awk/`
    done
}
################
#    主程序    #
################

# 变量设置

clear
funct_spript_info
sleep 1
echo -e "\e[1;32m正在执行 \e[0m"

SCRIPT_NAME=$0
WORK_DIR=$1
OLD_EXT=$2
NEW_EXT=$3
LENGHT=$#


funct_check_params
funct_batch_rename

## 脚本结束
echo -e "\e[1;32m执行成功\e[0m"
