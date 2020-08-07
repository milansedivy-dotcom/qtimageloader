#include "imageresources.h"

ImageResources::ImageResources(QObject *parent) : QObject(parent)
{

}

QQmlListProperty<ImageData> ImageResources::sourceFiles()
{
    return QQmlListProperty<ImageData>(this, this, &ImageResources::appendImage,nullptr, &ImageResources::imageData,nullptr);
}

void ImageResources::appendImage(ImageData* imageData)
{
    m_imageSourceList.append(imageData);
}

ImageData* ImageResources::imageData(int index) const
{
    return m_imageSourceList.at(index);
}

void ImageResources::appendImage(QQmlListProperty<ImageData>* list, ImageData* image)
{
    reinterpret_cast<ImageResources*>(list->data)->appendImage(image);
}

ImageData* ImageResources::imageData(QQmlListProperty<ImageData> *list, int index)
{
    return reinterpret_cast<ImageResources*>(list->data)->imageData(index);
}
