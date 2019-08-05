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



