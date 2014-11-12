#-------------------------------------------------
#
# Project created by QtCreator 2012-06-04T12:07:09
#
#-------------------------------------------------

QT       += core gui

TARGET = iGoBeatTool
TEMPLATE = app


SOURCES += main.cpp\
        mainwindow.cpp \
    bmsconvertdialog.cpp \
    BMS/bmsfileparser.cpp \
    BMS/bmsdata.cpp \
    Utility/utiliy.cpp \
    iGoBeat/qigobeatnode.cpp \
    BMS/bmstimeline.cpp \
    iGoBeat/igobeatsonginfo.cpp \
    UICompnent/checkboxlistitem.cpp \

HEADERS  += mainwindow.h \
    bmsconvertdialog.h \
    BMS/bmsfileparser.h \
    BMS/bmsdata.h \
    Utility/utiliy.h \
    iGoBeat/qigobeatnode.h \
    BMS/defineforbmsfile.h \
    BMS/bmstimeline.h \
    iGoBeat/igobeatsonginfo.h \
    UICompnent/checkboxlistitem.h \

FORMS    += mainwindow.ui \
    bmsconvertdialog.ui

#include(./quazip/quazip.pri)

