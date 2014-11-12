#include <QtGui/QApplication>
#include "mainwindow.h"
#include <QDebug>
#include <QString>
#include <Utility/utiliy.h>

class Test
{
public:
    int a;
    QString b;
};

const Test& ChangTestValue()
{
    Test test;
    test.a = 10;
    test.b = "Hello";
    return test;
}

int main(int argc, char *argv[])
{
    QApplication a(argc, argv);
    Utiliy::EncryptFile("/Users/guodong/Desktop/Test.txt");
    MainWindow w;
    w.show();
    //Test& test = ChangTestValue();
    //qDebug() << test.a << "  " << test.b;
    return a.exec();
}
