## shell 

### :deciduous_tree: 颜色

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
reset_col=""\e[0m]
red_col="\e[1;31m"
green="\e[1;32m"
```



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

