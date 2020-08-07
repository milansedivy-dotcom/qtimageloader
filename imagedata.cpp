#include "imagedata.h"
#include <QDebug>

ImageData::ImageData(QObject *parent)
{

}
ImageData::ImageData(QString imageSource, QString imageId)
{
    ImageData::setImage(imageSource, imageId);
}

void ImageData::setImage(QString imageSource, QString imageId)
{
    qDebug() << "QREGEXP: " << imageSource.remove(QRegularExpression("/^(file:\/{2})/"));
    qDebug() << "QREGEXP: " << imageSource.remove(QRegularExpression("file://"));
    if(imageId != NULL) {
        //Match 'file://' and remove it
        //m_imageSource = imageSource.remove(QRegularExpression("/^(file:\/{2})/")); <- no idea why this doesn't work, different regexp standard i guess
        m_imageSource = imageSource.remove(QRegularExpression("file://"));
        m_imageId = imageId;

        qDebug() << m_imageSource;
    }
    else
    {
        //Match everything up to and including the last slash '/' or backslash '\' (windows) and remove it
        m_imageSource = imageSource.remove(QRegularExpression("file://"));
        m_imageId = imageSource.remove(QRegularExpression("^(.*[\\\/])"));
        //m_imageSource = imageSource.remove(QRegularExpression("/^(file:\/{2})/"));

        qDebug() << m_imageSource;
    }
}

QString ImageData::imageSource()
{
    qDebug() << m_imageSource;
    return m_imageSource;
}

QString ImageData::imageId()
{
    return m_imageId;
}
