# TestShell

## test.sh

IFS环境变量定义了bash shell用作字段分隔符的一系列字符，默认情况下，以
- 空格
- 制表符
- 换行符
当做字段分隔符。

`IFS=$'\n'     #仅以换行符作为字段分割符`

```
IFS.OLD=$IFS
IFS=$'\n'
<在代码中使用新的IFS值>
IFS=$IFS.OLD
```

## makelog.sh

将文件夹中的内容重定向到log文件

## countFiles.sh

统计某文件夹下文件个数

## test Break

break 跳出循环

break n 跳出n层循环

## test continue n
 the results of the testContinueN.sh

```
Iteration 1:
  The result of 1 * 1 is 1
  The result of 1 * 2 is 2
Iteration 2:
  The result of 2 * 1 is 2
  The result of 2 * 2 is 4
Iteration 3:
Iteration 4:
  The result of 4 * 1 is 4
  The result of 4 * 2 is 8
Iteration 5:
  The result of 5 * 1 is 5
  The result of 5 * 2 is 10
```

## timesN.sh

接受一个命令行参数，在shell中为$1变量，$0为程序名

## 测试参数

当脚本使用参数时要判断是否存在数据

```
if [ -n "$1" ]
then 
    echo Hello $1, glad to meet you.
else
    echo "Sorry, you did not identify yourself. "
fi
```
## 参数统计

$# 对于命令行输入的参数的个数进行统计

##抓取所有数据

$*  和  $@

$*将命令行上所有参数当做一个单词保存，视为一个整体，而不是多个个体
$@将命令行上所有参数当作同一字符串的多个独立单词。可用for来遍历

## 移动变量

shift

变量$2的值会移到$1中，变量$1的值会被删除（$0的值，也就是程序名，不会改变）

##处理选项 (CommandOption Folder)

选项是跟在单破折线后面的单个字母，可以改变命令的行为。

## 合并选项

eg.  ./test.sh -ac

getopt命令
`set -- $(getopt -q ab:cd "$@")`

-q 忽略非法输入的提示，
:  表示b选项需要一个参数值

```
case "$1" in 
    -b) param="$2"
        echo "Found the -b option, with parameter value $param"
        shift ;;
```
getopts

```
while getopts :ab:c opt
do
    case "$opt" in
        a) echo "Found the -a option" ;;
        b) echo "Found the -b option, with value $OPTARG" ;;
        c) echo "Found the -c option" ;;
        *) echo "Unknow option: $opt" ;;
    esac
done
```

getopts命令解析命令行选项时会移除开头的单破折线。

##获得用户输入

```
echo -n "Enter your name:"
read name
echo "Hello $name, welcome to my program."
```

###  echo -n 不会在末尾输出换行符，允许脚本用户紧跟其后输入数据，而不是下一行。
让脚本看起来更像表单。

### read -p 选项，允许直接在read命令行指定提示符
```
read -p "Please enter your age: " age
days=$[ $age * 365 ]
echo "That makes you over $days days old! "
```
### read -t 选项，以秒为单位的计时器，计时器过后，返回非零退出状态码。
```
if read -t 5 -p "Please enter your name: " name
then 
    ...
```

### read -s选项，以隐藏的方式读取（密码等）
```
read -s -p "Enter your password: " pass
echo 
echo "Is your password really $pass?"
```

### 从文件中读取 
最常见的方法是对文件使用cat命令，将结果通过管道直接
传给含有read命令的while命令
```
count=1
cat test | while read line
do
    echo "Line $count: $line"
    count=$[ $count +1 ]
done
echo "Finished processing the file"
```

## 处理信号

系统和应用可以生成超过30个信号

### 生成信号
-中断进程
  Ctrl+C生成SIGINT信号，并将其发送给当前在shell中运行的所有进程
-暂停进程
  Ctrl+Z组合生成一个SIGTSTP信号，停止shell中运行的任何进程，停止进程与终止进程不同：停止进程会让程序继续保留在内存中，并能从上次停止的位置继续运行

### 捕获信号
`trap commands signals`

```
#!/bin/bash
#Testing signal trapping
#
trap "echo 'Sorry! I have trapped Ctrl-C'" SIGINT
#
echo This is a test script
#
count=1
while [ $count -le 10 ]
do 
    echo "Loop #$count"
    sleep 2
    count-$[ $count +1 ]
done
echo "This is the end of the test script"
```

### 捕获脚本退出

在trap命令后加上EXIT信号
`trap "echo Goodbye..." EXIT`

## 以后台模式运行脚本

只需要在命令后加&符号
注意，当后台进程运行时，它仍然会使用终端显示器来显示STDOUT和STDERR消息

### 在非控制台下运行脚本
即使退出终端会话，也让脚本一直以后台模式运行到结束，可以用nohup命令实现
`nohup ./test1.sh &`
和普通后台进程一样，shell会给命令分配一个作业号，linux系统会为其分配一个PID号

## 作业控制
启动、停止、终止以及恢复作业的这些功能统称为作业控制，通过作业控制，就能完全控制shell环境中所有进程的运行方式了。

### 查看作业
jobs命令允许查看shell当前正在处理的作业
note：脚本用$$变量来显示Linux系统分配给该脚本的PID

### 重启停止的作业
bg命令 重启默认作业
bg 作业号 （如果有多个作业）

## 调整谦让度

调度优先级是内核分配给进程的CPU时间（相对于其他进程）
Linux系统中，由shell启动的所有进程的调度优先级默认都是相同的。
调度优先级是个整数值，从-20（最高优先级）到+19（最低优先级）。默认情况下，以优先级0来启动所有进程

### nice命令
要让命令以更低的优先级运行，只需要用nice -n命令来指定新的优先级级别
`nice -n 10 ./test4.sh > test4.out &`
`[1] 4973`
`ps -p 4973 -o pid,ppid,ni,cmd      #用ps命令验证谦让度（NI列）`
nore:nice命令阻止普通系统用户来提高命令优先级

### renice命令
改变系统上已运行命令的优先级。允许你指定运行进程的PID来改变它的优先级。
只能降低进程的优先级
```
$ ./test11.sh &
[1] 5050
$
$renice -n 10 -p 5050
```

## 定时运行作业 
at命令和cron表







