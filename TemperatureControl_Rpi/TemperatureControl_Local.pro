TEMPLATE = app

QT += qml quick svg sql quickcontrols2 serialport
CONFIG += c++11

RESOURCES += res/qml.qrc \
    res/images.qrc \
    res/fonts.qrc \
    res/keyboard_style/keyboard_style.qrc \
    res/keyboard_layout/keyboard_layout.qrc \
    res/controls_style/controls_style.qrc

DEFINES += "QNTP_EXPORT="

# Additional import path used to resolve QML modules in Qt Creator's code model

QML_IMPORT_PATH += $$PWD/res/qml/components/acx

# Additional import path used to resolve QML modules just for Qt Quick Designer
QML_DESIGNER_IMPORT_PATH = ./qml/components/acx/

# The following define makes your compiler emit warnings if you use
# any feature of Qt which as been marked deprecated (the exact warnings
# depend on your compiler). Please consult the documentation of the
# deprecated API in order to know how to port your code away from it.
DEFINES += QT_DEPRECATED_WARNINGS

# You can also make your code fail to compile if you use deprecated APIs.
# In order to do so, uncomment the following line.
# You can also select to disable deprecated APIs only up to a certain version of Qt.
#DEFINES += QT_DISABLE_DEPRECATED_BEFORE=0x060000    # disables all the APIs deprecated before Qt 6.0.0

# Default rules for deployment.
qnx: target.path = /tmp/$${TARGET}/bin
else: unix:!android: target.path = /opt/$${TARGET}/bin
!isEmpty(target.path): INSTALLS += target

SOURCES += \
    local/main.cpp \
    screennames.cpp \
    serialcomm.cpp \
    devicelog.cpp \
    devicestate.cpp \
    qntp/NtpClient.cpp \
    qntp/NtpReply.cpp \
    ntpsync.cpp \
    comminterface.cpp \
    localconfig.cpp

HEADERS += \
    screennames.h \
    serialcomm.h \
    devicelog.h \
    devicestate.h \
    ../TemperatureControl_Arduino/SerialProtocol.h \
    qntp/config.h \
    qntp/NtpClient.h \
    qntp/NtpPacket.h \
    qntp/NtpReply.h \
    qntp/NtpReply_p.h \
    qntp/NtpTimestamp.h \
    qntp/QNtp.h \
    ntpsync.h \
    comminterface.h \
    localconfig.h
