#ifndef IMAGERESOURCES_H
#define IMAGERESOURCES_H

#include <QObject>
#include <QQmlListProperty>
#include "imagedata.h"

class ImageResources : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QQmlListProperty<ImageData> sourceFiles READ sourceFiles)

public:
    ImageResources();
    ~ImageResources() {}

    QQmlListProperty<ImageData> sourceFiles();
};

#endif // IMAGERESOURCES_H
