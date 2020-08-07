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


void ImageResources::appendMultipleImages(const QList<QUrl> &imageList)
{
    QList<QUrl>::const_iterator i;
    for (i = imageList.begin(); i != imageList.end(); i++)
    {
        ImageResources::appendImage(i->toString());
    }
    emit listChanged();
}

void ImageResources::appendDirectory(QString dirUrl)
{
     QDirIterator file(dirUrl.remove("file://"));
     while (file.hasNext())
     {
         if(file.fileName().endsWith(".jpg") || file.fileName().endsWith(".jpeg"))
         {
             ImageResources::appendImage(file.filePath());
         }
         file.next();
     }
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

int ImageResources::currentIndex()
{
    return m_currentIndex;
}

void ImageResources::setCurrentIndex(int newIndex)
{
    if (m_currentIndex != newIndex)
    {
        if (newIndex == m_imageSourceList.size())
            m_currentIndex = 0;
        else
            m_currentIndex = newIndex;
    }
    emit currentIndexChanged(m_currentIndex);
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
