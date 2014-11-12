#include "BMS/bmsfileparser.h"
#include <QtGui>

#define kBMSHeadFieldMark       "HEADER FIELD"
#define kBMSDefineFieldMark     "DEINE FIELD"
#define kBMSMainDataFieldMark   "MAIN DATA FIELD"

BMSFileParser::BMSFileParser()
{
}

enum EParserStep
{
    kUnStartParser = 0,
    kParserHeaderField,
    kParserDefineField,
    kParserMainDataField
};

EBMSFileParserErrorCode BMSFileParser::ParserBmsFile(const QString &path, BMSFileContent& content)
{
    // 1 open file
    QFileInfo info(path);
    if(!info.exists())
    {
        return kFileUnexist;
    }

    QFile in(path);
    if (!in.open(QIODevice::ReadOnly | QIODevice::Text))
    {
        qDebug() << "open file failed";
        return kOpenFileFailed;
    }

    // 2 parse
    QTextStream file_stream(&in);
    QString     line = file_stream.readLine();
    EParserStep parser_step = kUnStartParser;
    while(!line.isNull())
    {
        switch(parser_step)
        {
        case kUnStartParser:
        {
            if(line.contains(kBMSHeadFieldMark))
            {
                parser_step = kParserHeaderField;
            }
            break;
        }
        case kParserHeaderField:
        case kParserDefineField:
        {
            if(line.contains(kBMSMainDataFieldMark))
            {
                parser_step = kParserMainDataField;
            }

            QStringList temp_define_data = line.split(" ",QString::SkipEmptyParts);
            if(temp_define_data.count() > 1) //e.g. #PLAYER 2  #TITLE Song Title
            {
                QString define_name = temp_define_data.at(0);
                define_name = define_name.remove("#");
                define_name = define_name.trimmed();
                QString define_value;
                for(int i=1; i<temp_define_data.count(); i++)
                {
                    define_value += temp_define_data.at(i);
                    define_value += " ";
                }
                define_value = define_value.trimmed();
                content.define_field.insert(define_name,define_value);
            }
            else if(temp_define_data.count() == 1)  //e.g. #STAGEILE
            {
                QString define_name = temp_define_data.at(0);
                define_name = define_name.remove("#");
                define_name = define_name.trimmed();
                content.define_field.insert(define_name,"");
            }
            break;
        }
        case kParserMainDataField:
        {
            QStringList temp_define_data = line.split(":",QString::SkipEmptyParts);
            if(temp_define_data.count() == 2)
            {
                // e.g. #00122  measure_number(001) channel_number(22)
                QString measure_channel_str = temp_define_data.at(0);
                measure_channel_str = measure_channel_str.remove("#");
                measure_channel_str = measure_channel_str.trimmed();
                QString measure_str = measure_channel_str.left(3);  //小节编号是由左边3位十进制数表示的
                QString channel_str = measure_channel_str.right(2); //通道编号是由右边2位十进制数表示的

                BMSDataFieldElement data_field_element;
                data_field_element.measure_number = measure_str.toInt();
                data_field_element.channel_number = channel_str.toInt();
                data_field_element.data = temp_define_data.at(1).trimmed();
                content.data_field.append(data_field_element);
            }
            else if(temp_define_data.count() == 0)
            {
                break;
            }
            else
            {
                return kBMSMainDataFormateError;
            }
            break;
        }
        default:
        {
            break;
        }
        }

        // loop variable
        line = file_stream.readLine();
    }

    return kParserSuccess;
}
