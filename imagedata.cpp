#include "imagedata.h"
#include <QDebug>

ImageData::ImageData(QObject *parent)
{

}
ImageData::ImageData(QString imageSource, QString imageId)
{
    ImageData::setImage(imageSource, imageId);
}
ImageData::ImageData(QString imageSource)
{
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


QString ImageData::imageSource()
{
    return m_imageSource;
}

QString ImageData::imageId()
{
    return m_imageId;
}
