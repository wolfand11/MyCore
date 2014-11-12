#ifndef BMSFILEPARSER_H
#define BMSFILEPARSER_H

#include <QVector>
#include <QString>
#include <QMap>

struct BMSDataFieldElement
{
    int     measure_number;
    int     channel_number;
    QString data;
};

struct BMSFileContent
{
    QMap<QString,QString>           define_field;
    QVector<BMSDataFieldElement>    data_field;
};

enum EBMSFileParserErrorCode
{
    kParserSuccess  = 0,
    kFileUnexist,
    kOpenFileFailed,
    kBMSMainDataFormateError
};

class BMSFileParser
{
public:
    BMSFileParser();
    static EBMSFileParserErrorCode ParserBmsFile(/*in*/const QString& path,/*out*/BMSFileContent& content);
};

#endif // BMSFILEPARSER_H
