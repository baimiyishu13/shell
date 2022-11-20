## shell 

重点：sed、grep、awk、变量



### :deciduous_tree:脚本规范

```SH
#!/bin/bash

# Script Name	: 脚本吗
# Author			: 作者
# Created			: 06-August-2022 日期格式
# Last Modified	:
# Version			: 1.0	# 版本

# Modifications	:

# Description		: 描述

#################################
# Start of procedures/functions #
#################################

func函数

################
# Main Program #
################

主程序
```

注释





###  :deciduous_tree:颜色

echo 颜色输出文本

```SH
echo -e "\e[1;31m  this is : \e[0m"
```

+ \e[0m 恢复默认

常用：

+ 红色：\e[1;31m
+ 绿色：\e[1;32m

背景色 40-47

```SH
reset_col="\e[0m"
red_col="\e[1;31m"
green="\e[1;32m"
```



执行shell脚本

+ ./01.sh	需要权限

不需要权限

+ bash
+ source
+ .

### :deciduous_tree: 变量

---

变量定义：一个固定的字符串表示一个不固定的值

变量类型：

1. 自定义变量
2. 环境变量



#### :taco:自定义变量

**自定义变量：**

+ 定义：变量名=变量值  	[显示赋值；通过 read 读入]
+ 引用：$变量名 或 ${}
+ 查看：echo $变量名 
+ 取消：unset 变量
+ 范围：当前shell有效

注意事项：

1. 变量名:字母或下划线开头，区分大小写
2. set 命令 ： 查看所有变量

例如1：

```shell
#!/bin/sh

ip=127.0.0.1

ping -c1 $ip &>/dev/null
if [ $? -eq 0 ];then
        echo "success"
else
        echo "fail"
fi
```

+ $? : 上一个命令的返回值（0成功，1失败）

例如2：

```SH
#!/bin/sh

read -p "input ip: " ip

ping -c1 $ip &>/dev/null
if [ $? -eq 0 ];then
        echo "success"
else
        echo "fail"
fi
```



**使用 $1 赋值**

脚本后的覅一参数就是 $1

```sh
#!/bin/sh
ping -c1 $1 &>/dev/null
if [ $? -eq 0 ];then
        echo "$1 success"
else
        echo "$1 fail"
fi
```

执行

```SH
[root@node01 ~]# sh ping.sh 127.0.0.1
127.0.0.1 success				$1
```



#### :taco:环境变量

很少使用

```SH
export ip=1.1.1.1
```

作用域全局！

+ 引用：${ }
+ 查看：echo ${变量名}
+ 取消unset



#### :taco:位置变量

$1、$2、$3 ....



#### :taco:预定义变量

+ $0：脚本名
+ $*：所有参数
+ $@：所有参数
+ $#：参数个数
+ $$：当前进程PID
+ $!：上一个后台进程PID
+ $?：上一个命令返回值（0成功、1失败）



#### :taco:变量赋值方法

1. 显示赋值
2. read 从键盘读取（空格分隔，可以读取多个变量）



输双引号 和 单引号问题：

+ 双引号：弱引用，特殊字符需要转义
+ 单引号：强引用，不能出现变量



#### :taco:变量赋值方法

变量的运算

加减乘除

使用最多的：let

```SH
#!/bin/sh

ip=127.0.0.1
i=1
while [ $i -le 5 ]
do
        ping -c1 $ip &>/dev/null
        if [ $? -eq 0 ];then
                echo "$ip ip up"
        fi
        let i++
done
```



#### :taco:变量内容的删除替换

实际变量值没有改变

获取变量的长度`echo ${#url}`

```SH
#!/bin/sh
url=www.baidu.com
echo ${url}			# www.baidu.com			标准查看
echo ${url#www.}	# baidu.com				
echo ${url#*.}		# baidu.com				从前往后,最短匹配	
echo ${url##*.}		# com					贪婪匹配
echo ${url%.com}	# baidu.com
echo ${url%.*}		# baidu.com
echo ${url%%.*}		# www
```



#### :taco:索引和切片

用处非常大！

```SH
[root@node01 ~]# url=www.baidu.com
[root@node01 ~]# echo ${url:0:3}	# 0 -3
www
[root@node01 ~]# echo ${url:4}		# 从第四个开始全切
baidu.com
[root@node01 ~]# echo ${url:4:5}	# 从第四个开始向后取5个
baidu

```

**内容的替换：**

```sh
[root@node01 ~]# echo $url
www.baidu.com
[root@node01 ~]# echo ${url/baidu/bilibili}	# 替换
www.bilibili.com	
[root@node01 ~]# echo $url					
www.baidu.com
[root@node01 ~]# echo ${url/w/W}
Www.baidu.com
[root@node01 ~]# echo ${url//w/W}			# 贪婪匹配
WWW.baidu.com
```

**变量的替代：**

${变量名-新变量名}

+ 变量有值无值：不覆盖
+ 未被定义：覆盖 `-:` 冒号不会被替代

适用于给默认值



#### :taco:i++ 和 ++i

1. 对变量的影响
2. 对表达式的额影响

++ i 是指先把变量i的值加1，然后再把结果值赋值给左边变量；

i ++ 是先把变量i的值赋值给左边变量，然后再把变量i的值加1；



### :deciduous_tree:条件测试

---

最核心的点：判断某一个对象是否成立

条件测试主要分为3类：

1. 文件测试



#### :taco:文件测试

注意事项：

```
[ -d ${back_dir} ]	== test -d ${back_dir}

&& 和 || 使用
```

+ -e : 判断文件目录都可
+ -f : 判断文件是否存在

+ -d：目录
+ -r：读权限（当前用户）
+ -w
+ -x
+ -L： 判断链接文件
+ -b：设备文件

数值比较：

+ gt：大于
+ lt：小于
+ eq：等于；常用于判断上一个命令的返回是否 0
+ ne：不等
+ ge：大等
+ le：小等

```SH
#!/bin/sh

back_dir=/var/mysql_back

# 判断目录是否存在
if [ -d ${back_dir} ];then
        echo "${back_dir} exist"
else
        echo "error:No ${back_dir} directory"
        exit 1
fi
echo "开始备份..."

```

取反：叹号

```SH
#!/bin/sh

back_dir=/var/mysql_back

# 判断目录是否存在,不存在创建
if [ ! -d ${back_dir} ];then
        mkdir -p  ${back_dir}
else

        echo "${back_dir} is exist"
fi
echo "开始备份..."
```

#### :taco:字符串比较

注意事项：使用双引号

表达式直接可以加上 -a 或 -o

+ -a：并且[ 1==1 -o 2=2 ]
+ -o：或者[ 1==1 -o 2=3 ]

比较：

+ =
+ !=

```SH
[root@node01 script]# OS_VERSION=7
[root@node01 script]# [ "$OS_VERSION" = "7" ];echo $?
0
```

判断长度：

+ -z：长度为0
+ -n：长度不为0

```sh
[ -z "$OS_VERSION" ]	
[ -n "$OS_VERSION" ]	
```



其他 ：for i in `seq 10`; do echo $i; done

正则：[[ $num =~ ^[0-9]+$ ]]



### :deciduous_tree:case

---

if else 存在的问题

1. 结构混乱

模式匹配：case（可以看作ifelse的简洁版）

```sh
case 变量 in
模式1)
	命令序列
	;;
模式2)
	命令序列
	;;
模式3)
	命令序列
	;;
*)
	无匹配后命令序列
esac
```

简单的匹配模式案例（y/n）

```SH
#!/bin/bash

OS_VERSION=$1
case "${OS_VERSION}" in
7)
        echo "7"
        ;;
6)
        echo "6"
        ;;
*)
        echo "*"

esac
```

系统管理员

```SH
#!/bin/bash

read -p "username: " user

id ${user} &>/dev/null
if [ ! $? -eq 0 ];then
        echo "no such user ${user}"
        exit 1
fi

read -p "Are you sure?[y/n]: " action

case "${action}" in
y|Y|yes|YES)
        echo "$user successful"
        ;;
*)
        echo "error"
esac

```



### :deciduous_tree:if

---

流程控制

方括号区别：[[ ]] 可以使用正则匹配

```
if [ ];then
else
fi
```

```SH
if [ "OS_VERSION" ];then
elif ;then
else
fi
```



### :deciduous_tree:for

---

break & continue

单行写法

```SH
# for i in `seq 10`;do echo $i;done
```

for语法结构

```SH
for 变量名 [ in 取值列表 ]
do
	循环体
done
```

示例1：

```sh
#!/bin/bash

>ip.txt # 重定向

for i in {2..254}
do
	{
		...
	}& 后台执行
done
wait	# 等待
echo "ok"
```

示例1：

```SH
for i in `cat ip.txt`
do
done
```





### :deciduous_tree:while

---

for循环次数固定

更倾向于使用 while！

```SH
while 条件 # 返回为布尔值，true/false
do
done
```



```sh
while 条件 # 返回为布尔值，true/false
do
done < a.txt # 或者 $1
```



常用：

```SH
while true

i=0
while [ $i -lt 11 ]
```



### :deciduous_tree:函数

---

重要！

传参：$1,$2

变量：local

返回值：return $?

+ 完成特定功能的代码块
+ 便于复用代码
+ 必须先定义在使用

```sh
函数名()
{
	代码块
}
# 另一种方式（不常用）
function 函数名()
{

}
```

函数名命名规范（个人喜好）：

如：funct_check_use、funct_loginlog



**函数的参数：**

一、常用方式 , 定义好变量，函数后不加参数

```SH
script_name=$0 
work_dir=$1
old_ext=$2
new_ext=$3
NARG=$#

{						# Start the main program
  funct_check_params				# Call the procedure
  funct_batch_rename				# Call the procedure
}						# End of the main program 	

```

二、函数参数

```SH
funct_check_params 5	# 直接传 值，不推荐
funct_check_params $1
funct_check_params $2
funct_check_params $3
```



**函数的输出-赋值：**

```SH
funct_abc()
{

}
RESULT=`funct_abc`
```



在学习正则、awk、sed、grep前不得不了解管道符

### :deciduous_tree: 管道符

---



命令格式：

命令1 | 命令2 | 命令3 ...

命令之间加上管道符，前一个命令的执行结果变成一个文本，将结果传给第二个命令，再处理！

> 非常灵活

如：

```SH
[root@node01 script]# echo a.txt | awk -F"." '{print $2}'
txt
[root@node01 script]# echo a.txt | cut -f2 -d .
txt
```

### :deciduous_tree: 正则表达式

---

正则表达式（RE）：字符匹配模式

大多数：正则表达式被置于两个斜杠中！

元字符：表达的不是字面本身的含义



1.正则表达式的元字符

基本“

| 元字符     | 功能                     | 示例                     |
| ---------- | ------------------------ | ------------------------ |
| ^          | 行首定位符               | ^love                    |
| $          | 行尾定位符               | love$                    |
| .          | 匹配单个字符             | l..e                     |
| *          | 匹配前导字符0或多次      | ab*love  #b出现0次或多次 |
| .*         | 任意多字符               | 相当于shell中纯粹的 * 号 |
| []         | 匹配指定范围内一个字符   | [lL]ove                  |
| [ - ]      | 匹配指定范围内一个字符   | [a-z0-9]ove              |
| [ ^ ]      | 匹配不在指定范围内的字符 | [^a-z0-9]ove             |
| \          | 转移元字符               | love`\.`                 |
| `\<`       | 词首定位符               | `\<`love                 |
| `\>`       | 词尾定位符               | love`\>`                 |
| `\(..\)`   | 匹配稍后使用的字符标签   |                          |
| `x\{m\}`   | 字符出现m次              |                          |
| `x\{m,\}`  | 字符出现至少m次          |                          |
| `x\{m,n\}` | 字符出现m到n次           |                          |

扩展元字符

| 元字符       | 功能                 | 示例       |
| ------------ | -------------------- | ---------- |
| +            | 匹配一个或多个前导符 | [a-z]ove   |
| ？           | 匹配一个或0个前导符  | lo?ve      |
| a\|b         | 匹配a或b             | love\|hate |
| ()           | 组字符               |            |
| (..)(..)\1\2 | 标签匹配字符         |            |
| x{m}         | 字符x重复m次         |            |
| x{m,}        | 字符x重复至少m次     |            |
| x{m,n}       | 字符x重复m到n次      |            |

注意事项：

看到【*、?、+、{}】都是为前面字符服务



### :deciduous_tree: grep

---

grep命令|过滤

Usage: grep [OPTION]... PATTERN [FILE]...

> egrep

egrep = grep -E



grep：^ $ . * [] [^] 	`\< \> \(\) \{\}` 

egrep：？ + { } | （）

**grep选项：**

常用：-i、-v、-r

| 选项    | 描述                                   |
| ------- | -------------------------------------- |
| -i      | 忽略大小写                             |
| -I      | 只列出所在行文件名                     |
| -n      | 再每一行前面加上它再文件中对于的行号   |
| -c      | 显示成功匹配的行数                     |
| -s      | 禁止显示文件不存在或文件不可读错误信息 |
| -q      | 静默                                   |
| -v      | 反向查找，只显示不匹配的行             |
| -R，-r  | 递归针对目录                           |
| --color | 颜色                                   |
| -o      | 只显示匹配的内容                       |
| -B      |                                        |
| -A      |                                        |
| -C      |                                        |

示例:

```SH
[root@node01 script]# grep --h | grep -v
Usage: grep [OPTION]... PATTERN [FILE]...
[root@node01 script]# grep --h | grep "\-v"
  -v, --invert-match        select non-matching lines
  -V, --version             display version information and exit
```



### :deciduous_tree: sed

---

不需要交互（不可能在执行脚本时vi编辑）

多用于修改文件：

格式：

```SH
Usage: sed [OPTION]... {script-only-if-no-other-script} [input-file]...
# sed '' passwd # sed 命令 文件
```

注意事项：sed和grep不同，sed退出模式始终为0；只有语法错误此时非0

同样可以使用正则表达式：包括在斜杠之间



| 选项 | 描述                      |
| ---- | ------------------------- |
| -r   | 支持扩展元字符            |
| -i   | 直接修改文件内容          |
| -n   | 静默                      |
| -f   | 将sed的动作写在一个文件中 |

sed重点用于修改

#### :taco: 地址

决定对那些行操作！

```SH
sed -r 'd' passwd		# 删除全部行
sed -r '3d' passwd		# 删除第3行
sed -r '1,3d' passwd	# 删除第1-3行
sed -r '3,$d' passwd	# 删除第3-尾
sed -r '/root/d' passwd	# 删除root行  正则
sed -r '/root/!d' passwd	# 除了root行都删除
sed -r '/root/,5d' passwd	# 删除到第5行
sed -r '/root/,+5d' passwd	# 再删除20行

sed -r 's/root/alias/g' passwd	# g到结尾

sed -r '/^root/,5d' passwd

sed -r '1~2d' passwd	# 删除所有的奇数行
sed -r '0~2d' passwd	# 删除所有的偶数行
```



#### :taco: sed命令

| 命令 | 描述                                                         |
| ---- | ------------------------------------------------------------ |
| a    | 新增，后跟字符串，会出现在下一行                             |
| c    | 取代                                                         |
| d    | 删除； 2,4d  删除第2－4行                                    |
| i    | 插入，后接字符串，出现在上一行                               |
| p    | 打印，通常与sed -n一起；2p,4p输出第2行、第4行； 2，4p  输出第2－4行 |
| s    | 替换，搭配正则表达式<br />g 全局替换<br />i 忽略大小写       |
| r    | 从文件中读                                                   |
| w    | 写入文件                                                     |



### :deciduous_tree: awk

---

本身时变成语言，对文本和数据处理（逐行处理）

与sed不同，awk主要用于统计、切割

两种语法：

```SH
Usage: awk [options] -f progfile [--] file ...
Usage: awk [options] commands file ...
```



**-F选项：**

指定字段的分隔符

默认：空格、制表符

```SH
-F":"
-F"."
```



整行：$0、$1、$#



awk的commands可以分为三段

1. 行处理前：BEGIN{}
2. 行处理：{}     //一定要读文件
3. 夯锤后：END{}

```SH
[root@node01 script]# awk 'BEGIN{print 1/2}{print"ok"}END{print"------"}' /etc/hosts
0.5
ok	# 读一行做一次
ok
------
```



**awk正则表达式**

```SH
awk '/^root/' passwd
```

