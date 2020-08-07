#include "imageresources.h"

ImageResources::ImageResources(QObject *parent) : QObject(parent)
{

}

ImageResources::~ImageResources()
{
   QList<ImageData*>::iterator i;
   for (i = m_imageSourceList.begin(); i != m_imageSourceList.end(); ++i)
   {
       delete *i;
   }
}

QQmlListProperty<ImageData> ImageResources::sourceFiles()
{
    return QQmlListProperty<ImageData>(this, m_imageSourceList);
}

//void ImageResources::appendImage(ImageData* imageData)

void ImageResources::appendImage(QString imageData)
{
    ImageData* newData = new ImageData(imageData);
    m_imageSourceList.append(newData);
    emit listChanged();
}

void ImageResources::deleteImage(int index)
{
    m_imageSourceList.removeAt(index);
    emit listChanged();
}

void ImageResources::deleteAll()
{
    m_imageSourceList.clear();
    emit listChanged();
}

//int ImageResources::rowCount(const QModelIndex &parent) const
//{
//    return m_imageSourceList.size();
//}

//QVariant ImageResources::data(const QModelIndex &index, int role) const
//{
//    if (!index.isValid())
//        return QVariant();

//    if( role == Qt::DisplayRole)
//        if ( index.column() == 0)
//            return m_imageSourceList[index.row()]->imageId();
//    return QVariant();
//}

//ImageData* ImageResources::imageData(int index) const
//{
//    return m_imageSourceList.at(index);
//}

//void ImageResources::appendImage(QQmlListProperty<ImageData>* list, ImageData* image)
//{

//    reinterpret_cast<ImageResources*>(list->data)->appendImage(image);
//}

//ImageData* ImageResources::imageData(QQmlListProperty<ImageData> *list, int index)
//{
//    return reinterpret_cast<ImageResources*>(list->data)->imageData(index);
//}
