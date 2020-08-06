#include "imageresources.h"

ImageResources::ImageResources(QObject *parent) : QObject(parent)
{

}

QQmlListProperty<ImageData> ImageResources::sourceFiles()
{
    //return QQmlListProperty<ImageData>(this, this, &ImageResources::appendImage,nullptr,nullptr,nullptr);
}

void ImageResources::appendImage(ImageData* imageData)
{
    m_imageSourceList.append(imageData);
}
