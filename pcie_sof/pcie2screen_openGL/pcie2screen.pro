#-------------------------------------------------
#
# Project created by QtCreator 2018-01-30T17:01:57
#
#-------------------------------------------------

QT       += core gui
QT       += openglwidgets

greaterThan(QT_MAJOR_VERSION, 4): QT += widgets

TARGET = pcie2screen
TEMPLATE = app
DESTDIR = $$PWD/../__output
OBJECTS_DIR = $$PWD/../__build/pcie2screen

SOURCES += main.cpp\
    OpenGL.cpp \
    event_thread.cpp \
    mainwindow.cpp \
    set_capture.cpp \
    xdma_programe.cpp

HEADERS  += \
    OpenGL.h \
    event_thread.h \
    mainwindow.h \
    set_capture.h \
    xdma_programe.h \
    xdma_public.h

FORMS += \
    mainwindow.ui

RC_ICONS = favicon.ico

# Default rules for deployment.
qnx: target.path = /tmp/$${TARGET}/bin
else: unix:!android: target.path = /opt/$${TARGET}/bin
!isEmpty(target.path): INSTALLS += target


RESOURCES +=
DEFINES += STRSAFE_NO_DEPRECATE

LIBS += -lsetupapi


