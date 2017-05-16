#include "cpuinfo.h"

#include <QGuiApplication>
#include <QQmlApplicationEngine>

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;
    qmlRegisterType<CPUInfo>("org.device.info", 1, 0, "CPUInfo");
    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));

    return app.exec();
}
