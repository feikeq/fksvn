#!/bin/sh
#mac里面.sh双击无法运行，而是编辑 要能够双击运行的把后缀名改成.command 当然你的内容必须是shell

 

#同步(checkout)服务器数据到本地 svn checkout <url> [directory] 不指定本地目录全路径，则检出到当前目录下。
#svn checkout --username 用户名 --password 密码 --non-interactive -q 仓库地址
# 全局选项:
# --username ARG : 指定用户名称 ARG
# --password ARG : 指定密码 ARG
# --no-auth-cache : 不要缓存用户认证令牌
# --non-interactive : 不要交互提示
# --trust-server-cert : 不提示的接受未知的 SSL 服务器证书(只用于选项 “--non-interactive”)
# --config-dir ARG : 从目录 ARG 读取用户配置文件
# --config-option ARG : 以下属格式设置用户配置选项：
# FILE:SECTION:OPTION=[VALUE]


#svn checkout --username $user --password $pass --no-auth-cache --non-interactive $svnurl
#svn checkout --username $user --password $pass --no-auth-cache --non-interactive $svnurl "mycode"


#增加(add)本地数据到服务器  svn add <directory|file>
#svn st | awk '{if ( $1 == "?") { print $2}}' | xargs svn add  


#提交(commit)本地文档到服务器 svn commit -m "" [directory|file] 前提是服务器上已经有此文件。
#svn commit -m "提交当前目录下的全部在版本控制下的文件"




svnurl=""
user=""
pass=""

 

while [ 1 -eq 1 ]  
do

	echo " "
	echo " "
	echo "--------------废客SVN操作--------------"
	echo " 0) 配置SVN信息" 
	echo " 1) 同步(checkout)服务器数据到本地"  
	echo " 2) 增加(add)和删除(del)本地数据到服务器"  
	echo " 3) 提交(commit)本地文档到服务器"
	echo " x) 退出程序"
	echo " "
	echo "--------------$PWD--------------"
	read -p "请选择操作: " input  
	echo "-------------- $svnurl ---------------" 
	

	case $input in    
	    0)
		read -p "SVN仓库地址: " svnurl  
		read -p "SVN用户名: " user  
		read -p "SVN密码: " pass ;;

	    1)  
	    echo "正在同步服务器数据到本地..."  
	    svn checkout --username $user --password $pass --no-auth-cache --non-interactive $svnurl "./fksvn" ;;  

	    2)  
	    echo "往版本库中添加新的文件"
	    svn status fksvn/|grep ! |awk '{print $2}'|xargs svn del
	    #svn status --no-ignore | grep '^[I?]' | sed 's/^[I?]//' | xargs rm -rf
	    svn add fksvn/* --force --no-ignore ;;

	    3)  
	    echo "正在提交本地文档到服务器..." 
	    svn commit -m "提交当前目录下的全部在版本控制下的文件"  fksvn ;;

	    *)
	    echo "关闭程序"
	    exit;;  
	esac  


done

