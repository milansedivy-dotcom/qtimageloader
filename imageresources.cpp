#include "imageresources.h"

ImageResources::ImageResources(QObject *parent) : QObject(parent)
{

}

QQmlListProperty<ImageData> ImageResources::sourceFiles()
{
    return QQmlListProperty<ImageData>(this, this, &ImageResources::appendImage,nullptr,nullptr,nullptr);
}

void ImageResources::appendImage(ImageData* imageData)
{
    m_imageSourceList.append(imageData);
}

void ImageResources::appendImage(QQmlListProperty<ImageData>* list, ImageData* image)
{
    reinterpret_cast<ImageResources*>(list->data)->appendImage(image);
}
