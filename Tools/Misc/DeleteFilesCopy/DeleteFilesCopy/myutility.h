#ifndef MYUTILITY_H
#define MYUTILITY_H

enum EFileInfoType
{
    kInvalidFileInfo = 0,
    kFileAbsolutePathInfo,
    kFileNameInfo
};

class QStringList;
class QString;

class MyUtility
{
public:
    MyUtility();
    static void GetFilesInfo(const QString& dirctory_path,
                             QStringList& file_info_list,
                             EFileInfoType type);
};

#endif // MYUTILITY_H
