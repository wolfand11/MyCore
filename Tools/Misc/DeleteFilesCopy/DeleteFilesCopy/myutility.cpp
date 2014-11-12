#include "myutility.h"
#include <QtGui>

MyUtility::MyUtility()
{
}

void MyUtility::GetFilesInfo(const QString& dirctory_path,QStringList& file_info_list,EFileInfoType type)
{
    QDir root_directory;
    root_directory.setPath(dirctory_path);
    foreach(QFileInfo info, root_directory.entryInfoList())
    {
        if(info.isFile())
        {
            switch(type)
            {
                case kFileAbsolutePathInfo:
                {
                    file_info_list.append(info.absoluteFilePath());
                    break;
                }
                case kFileNameInfo:
                {
                    file_info_list.append(info.fileName());
                    break;
                }
                default:
                {
                    QApplication::exit();
                }
            }
        }
        else if(info.isDir())
        {
            if(info.fileName() == "." || info.fileName() == "..")
            {
                continue;
            }
            else
            {
                GetFilesInfo(info.absoluteFilePath(),file_info_list,type);
            }
        }
    }
}


