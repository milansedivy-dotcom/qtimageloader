#ifndef IMAGERESOURCES_H
#define IMAGERESOURCES_H

#include <QObject>
#include <QVector>
#include <QQmlListProperty>
#include "imagedata.h"

class ImageResources : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QQmlListProperty<ImageData> sourceFiles READ sourceFiles)

public:
    ImageResources(QObject *parent = nullptr);
    ~ImageResources() {}

    QQmlListProperty<ImageData> sourceFiles();
    void appendImage(ImageData* imageData);

private:
    QVector<ImageData *> m_imageSourceList;
    static void appendImage(QQmlListProperty<ImageData>* list, ImageData* image);
};

#endif // IMAGERESOURCES_H
