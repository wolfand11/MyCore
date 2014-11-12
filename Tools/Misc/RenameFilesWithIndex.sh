
FILESPATH=$1
FILESUFFIX=$2
STARTINDEX=$3
ARGUMENT_COUNT=$#

if test $ARGUMENT_COUNT -eq 0
    then
    echo "usage:./RenameFiles.sh /test/dir .rmvb 11"
    echo "files will be H11.rmvb H12.rmvb ..."
    exit 0
fi

cd "$FILESPATH"

INDEXCOUNT=$STARTINDEX
for i in $(ls *"$FILESUFFIX" | tr " " "?" | grep -v ^d)
do
    echo "----$i"
    echo "----H$INDEXCOUNT$FILESUFFIX"
    mv "$i" "H$INDEXCOUNT$FILESUFFIX"
    ((INDEXCOUNT++))
done