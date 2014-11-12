INCLUDEPATH += $$PWD
DEPENDPATH += $$PWD
HEADERS += $$PWD/crypt.h \
           $$PWD/ioapi.h \
           $$PWD/JlCompress.h \
           $$PWD/quaadler32.h \
           $$PWD/quachecksum32.h \
           $$PWD/quacrc32.h \
           $$PWD/quazip.h \
           $$PWD/quazipfile.h \
           $$PWD/quazipfileinfo.h \
           $$PWD/quazipnewinfo.h \
           $$PWD/unzip.h \
           $$PWD/zip.h
SOURCES += $$PWD/qioapi.cpp \
           $$PWD/JlCompress.cpp \
           $$PWD/quaadler32.cpp \
           $$PWD/quacrc32.cpp \
           $$PWD/quazip.cpp \
           $$PWD/quazipfile.cpp \
           $$PWD/quazipnewinfo.cpp \
           $$PWD/unzip.c \
           $$PWD/zip.c

unix:!symbian {
    headers.path=$$PREFIX/include/quazip
    headers.files=$$HEADERS
    target.path=$$PREFIX/lib
    INSTALLS += headers target
    LIBS += -lz
        OBJECTS_DIR=.obj
        MOC_DIR=.moc

}

win32 {
    headers.path=$$PREFIX/include/quazip
    headers.files=$$HEADERS
    target.path=$$PREFIX/lib
    INSTALLS += headers target

}
