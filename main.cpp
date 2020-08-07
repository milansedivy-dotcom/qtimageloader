#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include "qtimageprovider.h"
#include "imageresources.h"
#include "imagedata.h"

int main(int argc, char *argv[])
{
    ImageResources imageResources;

    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);

    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;
    const QUrl url(QStringLiteral("qrc:/main.qml"));
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
                     &app, [url](QObject *obj, const QUrl &objUrl) {
        if (!obj && url == objUrl)
            QCoreApplication::exit(-1);
    }, Qt::QueuedConnection);


    //qmlRegisterType<ImageResources>("qt.noob.imageResources", 1, 0, "ImageResources");
    qmlRegisterType<ImageData>("qt.noob.imageData", 1, 0, "ImageData");
//    qRegisterMetaType<ImageResources*>("ImageResources");
//    qRegisterMetaType<ImageData*>("ImageData");

    engine.rootContext()->setContextProperty("_imageResources", &imageResources);
    imageResources.appendImage("/home/vakokocurik/Downloads/Phalaenopsis_JPEG.jpg");

    engine.addImageProvider(QLatin1String("myprovider"), new QtImageProvider);
    engine.load(url);

    return app.exec();
}
