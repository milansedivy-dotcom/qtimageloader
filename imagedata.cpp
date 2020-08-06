#include "imagedata.h"

ImageData::ImageData(QObject *parent)
{

}
ImageData::ImageData(QString imageSource, QString imageId)
{
    ImageData::setImage(imageSource, imageId);
}

void ImageData::setImage(QString imageSource, QString imageId)
{
    if(imageId != NULL) {
        //Match everything before last the last slash '/' and remove it
        m_imageSource = imageSource.remove(QRegularExpression("/^(file:\/{2})/"));
        //Match everything up to and including the last slash '/' or backslash '\' (windows) and remove it
        m_imageId = m_imageSource.remove(QRegularExpression("^(.*[\\\/])"));
    }
    else
        m_imageId = imageId;
}

QString ImageData::imageSource()
{
    return m_imageSource;
}

QString ImageData::imageId()
{
    return m_imageId;
}
