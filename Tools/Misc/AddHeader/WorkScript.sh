#!/bin/bash

#功能: 为每个文件添加Header
#说明: 对dirname目录下的所有后缀为xxx的文件进行操作。为每一个文件添加一个Header

# usage:
ARGUMENT_COUNT=$#
if test $ARGUMENT_COUNT -eq 1
    then
    if test $1 = "-h"
    then
	echo "usage 1(argcount=1): ./XXXX.sh header.txt xxx dirname"
	exit 0
    fi
fi

#---------------------------------------------------------------------------------------
# Helper Function
#---------------------------------------------------------------------------------------
g_dirOrFileAbsoluteFullPath=
function GetAbsoluteFullPath()
{
    if test $# -ne 1
    then
	echo "GetAbsoluteFullPath argument count !=1"
	exit
    fi

    local dirOrFile=$1
    if test $dirOrFile=="/*"
    then
	g_dirOrFileAbsoluteFullPath=$dirOrFile
    else
	g_dirOrFileAbsoluteFullPath=$(pwd)/$dirOrFile	
    fi
    
    if test -f $g_dirOrFileAbsoluteFullPath || test -d $g_dirOrFileAbsoluteFullPath
    then
	return 0
    else
	echo $g_dirOrFileAbsoluteFullPath" don't exist!"
	g_dirOrFileAbsoluteFullPath=""	
	return 1
    fi
}
#---------------------------------------------------------------------------------------
# Logic
#---------------------------------------------------------------------------------------

#echo LogicStart--------------------------------------
if test $ARGUMENT_COUNT -ne 3
then
    echo "argument count != 3"
    exit    
fi

HEADER_FILE_FULL_PATH=$1
DES_FILE_SUFFIX=$2
DES_FILE_PARENT_DIR=$3

GetAbsoluteFullPath $DES_FILE_PARENT_DIR
if test $? -ne 0
then
    echo $DES_FILE_PARENT_DIR" don't exist"
    exit
fi
DES_FILE_PARENT_DIR=$g_dirOrFileAbsoluteFullPath

## Get header content
HEADER_CONTENT=$(cat $HEADER_FILE_FULL_PATH)
echo $HEADER_CONTENT
#echo "$HEADER_CONTENT"|grep -o "[^ ]\+\(\+[^ ]\+\)*" > $DES_FILE_PARENT_DIR"/temp.txt"
echo "$HEADER_CONTENT" > $DES_FILE_PARENT_DIR"/temp.txt"