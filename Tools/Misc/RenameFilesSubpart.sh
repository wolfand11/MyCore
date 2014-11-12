
FILESPATH=$1
FILESUFFIX=$2
OLD_SUBPART=$3
NEW_SUBPART=$4
ARGUMENT_COUNT=$#

if test $ARGUMENT_COUNT -eq 0
    then
    echo "usage:./RenameFilesSubpart.sh /test/dir .rmvb oldsubname newsubname"
    echo "filename_oldsubname_1.rmvb will be filename_newsubname_1.rmvb"
    exit 0
fi

cd "$FILESPATH"

for i in $(ls *"$FILESUFFIX" | tr " " "?" | grep -v ^d)
do
    echo "----$i"
    echo ${i/$OLD_SUBPART/$NEW_SUBPART}
    mv "$i" "${i/$OLD_SUBPART/$NEW_SUBPART}"
done