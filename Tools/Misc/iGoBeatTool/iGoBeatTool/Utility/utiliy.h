#ifndef UTILIY_H
#define UTILIY_H
#include <QVector>
#include <QMap>
#include <QStringList>
#include <QList>

enum EFileInfoType
{
    kInvalidFileInfo = 0,
    kFileAbsolutePathInfo,
    kFileNameInfo
};

enum EStringToStringListConvertDirection
{
    kInvalidDirection = 0,
    kFromLeftToRight,
    kFromRightToLeft
};

class Utiliy
{
public:
    Utiliy();

    template<typename Type>
    static void PrintVector(const QVector<Type>& values);
    template<typename Type>
    static void PrintList(const QList<Type>& values);

    static bool Reverse(const QString& in_str,QString& out_str);
    static bool StringToStringList(const QString& str,QStringList& list, int base,
                                   EStringToStringListConvertDirection direction=kFromLeftToRight);
    static void GetFilesInfo(const QString& dirctory_path,QStringList& file_info_list,EFileInfoType type);
    static bool RemoveDirectory(const QString& directory_path);
    static void EncryptFile(const QString& file_path,const QString& out_file_path="");
};

template<typename Type>
void Utiliy::PrintVector(const QVector<Type>& values)
{
    foreach(const Type& v,values)
    {
        qDebug() << v.ToString();
    }
}
template<typename Type>
void Utiliy::PrintList(const QList<Type>& values)
{
    foreach(const Type& v,values)
    {
        qDebug() << v.ToString();
    }
}
#endif // UTILIY_H
