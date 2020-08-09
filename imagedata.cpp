#include "imagedata.h"
#include <QDebug>


ImageData::ImageData(QObject *parent)
{
    m_currentRotation = 0;
}
ImageData::ImageData(QString imageSource, QString imageId)
{
    m_currentRotation = 0;
    ImageData::setImage(imageSource, imageId);
}
ImageData::ImageData(QString imageSource)
{
    m_currentRotation = 0;
    ImageData::setImage(imageSource);
}
ImageData::~ImageData()
{

}
void ImageData::setImage(QString imageSource, QString imageId)
{
    if(imageId != NULL) {
        //Match 'file://' and remove it
        //m_imageSource = imageSource.remove(QRegularExpression("/^(file:\/{2})/")); <- no idea why this doesn't work, different regexp standard i guess
        m_imageSource = imageSource.remove(QRegularExpression("file://"));
        m_imageId = imageId;
    }
    else
    {
        //Either move regular expressions into a singleton OR use QMap::lowerBound
        //m_imageSource = imageSource.remove(QRegularExpression("/^(file:\/{2})/"));
        m_imageSource = imageSource.remove(QRegularExpression("file://"));
        //Match everything up to and including the last slash '/' or backslash '\' (windows) and remove it
        m_imageId = imageSource.remove(QRegularExpression("^(.*[\\\/])"));
    }
}

void ImageData::setImageSource(QString newImageSource)
{
    m_imageSource = newImageSource.remove(QRegularExpression("file://"));
    emit imageSourceChanged();
}

void ImageData::setCurrentRotation(int newRotation)
{
    if (m_currentRotation != newRotation)
        m_currentRotation = newRotation;
}

int ImageData::currentRotation()
{
    return m_currentRotation;
}

QString ImageData::imageSource()
{
    return m_imageSource;
}

QString ImageData::imageId()
{
    return m_imageId;
}
