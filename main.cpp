#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include "config.h"

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    app.setOrganizationName("shemeshg");
    app.setApplicationVersion(PROJECT_VER);
    //app.setOrganizationDomain("somecompany.com");
    app.setApplicationName("Cakebrewjs2");


    QQmlApplicationEngine engine;
    QObject::connect(
        &engine,
        &QQmlApplicationEngine::objectCreationFailed,
        &app,
        []() { QCoreApplication::exit(-1); },
        Qt::QueuedConnection);
    engine.loadFromModule("MainQml", "Main");

    return app.exec();
}
