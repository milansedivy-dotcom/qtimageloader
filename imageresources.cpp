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
     //check and load last file
     if(file.fileName().endsWith(".jpg") || file.fileName().endsWith(".jpeg"))
     {
         ImageResources::appendImage(file.filePath());
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
