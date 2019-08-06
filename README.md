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





