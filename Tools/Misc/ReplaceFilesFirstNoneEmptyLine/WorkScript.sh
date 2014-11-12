#!/bin/bash

#功能: 修改文件非空起始行的内容
#说明: 对dirname目录下的所有后缀为xxx的文件进行操作。将第一个非空起始行，修改为newline.txt中第一行的内容

# usage:
ARGUMENT_COUNT=$#
if test $ARGUMENT_COUNT -eq 1
    then
    if test $1 = "-h"
    then
	echo "usage 1(argcount=1): ./XXXX.sh newline.txt xxx dirname"
	exit 0
    fi
fi

#---------------------------------------------------------------------------------------
# Helper Function
#---------------------------------------------------------------------------------------
g_firstUnemptyLineContent=
function GetFirstUnemptyLineContent()
{
    if test $# -ne 1
    then
	echo "GetFirstUnemptyLineContent argument count !=1"
	exit
    fi

    local fileName=$1
    local lineCount=1
    g_firstUnemptyLineContent=$(awk -f ./awk_GetFirstUnemptyLineContent.awk $fileName)
    return $?
}

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
NEW_LINE_FILE_FULL_PATH=$1
DES_FILE_SUFFIX=$2
DES_FILE_PARENT_DIR=$3
REG_CONDITION="^#\\\+Tile"

GetAbsoluteFullPath $DES_FILE_PARENT_DIR
if test $? -ne 0
then
    echo $DES_FILE_PARENT_DIR" don't exist"
    exit
fi
DES_FILE_PARENT_DIR=$g_dirOrFileAbsoluteFullPath

## Get new line content
NEW_LINE_CONTENT=""
if test $NEW_LINE_FILE_FULL_PATH -z
then
    NEW_LINE_CONTENT=""
    
    echo "Operation is RemoveFirstLine with reg condition"
else
    GetFirstUnemptyLineContent $NEW_LINE_FILE_FULL_PATH
    if test $? -ne 0
    then
	echo "Don't find unempty content in "$NEW_LINE_FILE_FULL_PATH
	exit
    fi
    
    NEW_LINE_CONTENT=$g_firstUnemptyLineContent
    echo "Operation is ReplaceFirstLine with reg condition"
fi


## Remove empty header
for i in $(find $DES_FILE_PARENT_DIR -type f | grep "$DES_FILE_SUFFIX$")
do
    echo "$i"
    fileContent=$(cat "$i" | awk -f ./awk_RemoveSpaceHeader.awk)
    echo "$fileContent" > $i
done

#exit

# Remove 符合匹配条件的第1行
for i in $(find $DES_FILE_PARENT_DIR -type f | grep "$DES_FILE_SUFFIX$")
do
    echo "$i"
    fileContent=$(cat "$i" | awk -f ./awk_RemoveFirstLineWithRegCondition.awk -v reg=$REG_CONDITION)
    echo "$fileContent" > $i
done

## Add New First Line
for i in $(find $DES_FILE_PARENT_DIR -type f | grep "$DES_FILE_SUFFIX$")
do
    echo "$i"            
    fileContent=$(cat "$i" | awk -f ./awk_RemoveSpaceHeader.awk)
    
    if test $NEW_LINE_CONTENT -n
    then
	echo $NEW_LINE_CONTENT > $i	
    fi
    echo "$fileContent" >> $i
done
