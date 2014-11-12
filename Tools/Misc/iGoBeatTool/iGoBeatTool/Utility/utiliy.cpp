#include "utiliy.h"
#include <algorithm>
#include <QDir>
#include <QFileInfo>
#include <QApplication>
#include <QDebug>

Utiliy::Utiliy()
{
}

bool Utiliy::Reverse(const QString &in_str, QString &out_str)
{
    QByteArray str_bytes = in_str.toAscii();
    char *str_bytes_pointer = str_bytes.data();
    std::reverse(str_bytes_pointer, str_bytes_pointer+in_str.length());
    out_str = QString(str_bytes_pointer);
    return true;
}

bool Utiliy::StringToStringList(const QString &str,QStringList &list, int base, EStringToStringListConvertDirection direction)
{
    QString temp_str;
    if(direction == kFromLeftToRight)
    {
        temp_str = str;
    }
    else if(direction == kFromRightToLeft)
    {
        temp_str = Utiliy::Reverse(str,temp_str);
    }
    else
    {
        return false;
    }

    for(int i=0; i<temp_str.length(); i=i+base)
    {
        list.append(temp_str.mid(i,base));
    }
    return true;
}


bool Utiliy::RemoveDirectory(const QString &directory_path)
{
    QStringList file_path_list;
    Utiliy::GetFilesInfo(directory_path,file_path_list,kFileAbsolutePathInfo);
    // 1 remove file
    QDir dir;
    foreach(const QString& path,file_path_list)
    {
        dir.setPath(path);
        dir.remove(path);
    }
    // 2 remove path
    dir.setPath(directory_path);
    foreach(const QFileInfo& fileInfo,dir.entryInfoList())
    {
        qDebug() << fileInfo.absoluteFilePath() << endl;
        dir.rmpath(fileInfo.absoluteFilePath());
    }
    return true;
}


void Utiliy::GetFilesInfo(const QString& dirctory_path,QStringList& file_info_list,EFileInfoType type)
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

void Utiliy::EncryptFile(const QString &file_path, const QString &out_file_path)
{
    if(file_path.isEmpty()) return ;

    QFile inFile(file_path);
    if(inFile.open(QIODevice::ReadOnly) == false)
    {
        return ;
    }

    QString outFileName;
    if(out_file_path.isEmpty())
    {
        outFileName = file_path;
    }
    else
    {
        outFileName = out_file_path;
    }
    QFile outFile(outFileName);
    if(outFile.open(QIODevice::ReadWrite) == false)
    {
        return ;
    }

    QDataStream in(&inFile);
    QDataStream out(&outFile);

    quint8 mask = 0x47;

    while(in.atEnd() == false)
    {
        quint8 value;
        in>>value;
        value ^= mask;
        mask = (char)((mask<<1) + ( ((mask>>3) & 0x01 ) ^ ((mask>>4) & 0x01 ) ^ ((mask>>5) & 0x01 ) ^ ((mask>>7) & 0x01 )));
        out<<value;
    }

    inFile.close();
    outFile.close();
}
