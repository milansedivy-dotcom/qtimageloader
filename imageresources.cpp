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
    if (m_fileLookup.contains(newData->imageSource())) {
        delete newData;
    } else {
        m_fileLookup.insert(newData->imageSource(), m_imageSourceList.size());
        m_imageSourceList.append(newData);
        emit listChanged();
    }
    //temporary
    Exiv2::Image::AutoPtr image = Exiv2::ImageFactory::open((newData->imageSource()).toStdString());
    assert(image.get() != 0);
    image->readMetadata();
    Exiv2::ExifData &exifData = image->exifData();
    if (exifData.empty())
    {
        qDebug() << "No Exif data found in file";
    }
    else
    {
        qDebug() << "I've found something";
        qDebug() << "DateTime: " << QString::fromStdString(exifData["Exif.Image.DateTime"].toString());
    }
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
    m_fileLookup.remove(m_imageSourceList.at(index)->imageSource());
    m_imageSourceList.removeAt(index);
    emit listChanged();
}

void ImageResources::deleteAll()
{
    m_imageSourceList.clear();
    m_fileLookup.clear();
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
