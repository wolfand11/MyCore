#include "qigobeatnode.h"
#include <QDebug>

QString QiGoBeatNodeData::iGoBeatNodeTemplate()
{
    QString str = QString();
    str =  str.sprintf("    <key>Note-%05d</key>\n",this->m_nodeIndex);
    str += QString("    <dict>\n");
    str += QString("        <key>ExtraNumber</key>\n");
    str += QString("        <integer>%1</integer>\n").arg(this->m_nodeExtraNumber);
    str += QString("        <key>ExtraString</key>\n");

    if(m_nodeType == IGOBEATNODETYPE_LONG)
    {
        str += QString("        <string>%1</string>\n").arg(this->convertTimeFromIntToString(this->m_nodeEndTime));
    }
    else
    {
        str += QString("        <string>0</string>\n");
    }

    str += QString("        <key>StartPosition</key>\n");
    str += QString("        <string>%1</string>\n").arg(this->convertTimeFromIntToString(this->m_nodeStartTime));
    str += QString("        <key>Type</key>\n");

    if(m_isIGoBeatPosition == true)
    {
        if(m_nodePositionStr.isEmpty())
        {
            m_nodePositionStr = this->convertPositionFromIntToString(this->m_nodePosition);
        }
        str += QString("        <string>%1</string>\n").arg(m_nodePositionStr);
    }
    else
    {
        str += QString("        <string>%1</string>\n").arg(this->convertPositionFromIntToInt(this->m_nodePosition));
    }

    str += QString("    </dict>\n");
    return str;
}

QString QiGoBeatNodeData::convertTimeFromIntToString(int time)
{
    int intT = time;
    int mm = intT/60000;
    int ss = (intT - mm*60000)/1000;
    int kk = intT%1000;

    QString str;
    str = str.sprintf("%02d:%02d:%03d",mm,ss,kk);
    return str;
}

QString QiGoBeatNodeData::convertPositionFromIntToString(int index)
{
    QStringList abcd;
    abcd.append("A");
    abcd.append("B");
    abcd.append("C");
    abcd.append("D");

    int randA = index/4;
    int rand1 = index%4;

    QString str = QString("%1%2").arg(abcd.at(randA)).arg(rand1 + 1);

    if(m_nodeType == IGOBEATNODETYPE_LONG)
    {
        str.insert(1,"L");
    }
    else if(m_nodeType == IGOBEATNODETYPE_REWARD)
    {
        str.insert(1,"X");
    }

    return str;
}

int QiGoBeatNodeData::convertPositionFromIntToInt(int index)
{
    QList<int> position;
    position<<6<<1<<2<<3<<4<<5<<8<<9;
    return position.indexOf(index) + 1;
}

QString QiGoBeatNodeFile::plistHeader()
{
    QString str = QString("");
    str += QString("<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n");
    str += QString("<!DOCTYPE plist PUBLIC \"-//Apple//DTD PLIST 1.0//EN\" \"http://www.apple.com/DTDs/PropertyList-1.0.dtd\">\n");
    str += QString("<plist version=\"1.0\">\n");
    return str;
}

bool QiGoBeatNodeFile::createPListFile(const QString& filePath, QList<QiGoBeatNodeData> &datas)
{
    QString  file_path = filePath;
    QFile file(file_path);
    if(file.open(QIODevice::WriteOnly) == false)
    {
        qDebug() << QString("Open File Failed:") << filePath;
        return false;
    }

    QTextStream out(&file);
    out.setCodec("UTF-8");
    out<<QiGoBeatNodeFile::plistHeader();
    out<<QString("<dict>\n");

    foreach (QiGoBeatNodeData data, datas)
    {
        out<<data.iGoBeatNodeTemplate();
    }

    out<<QString("</dict>\n");
    out<<QString("</plist>\n");
    file.close();
    return true;
}
