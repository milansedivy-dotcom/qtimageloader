#include "qtimageprovider.h"

//QImageProvider::QImageProvider()
//{

//}

QImage QtImageProvider::requestImage(const QString &id, QSize* size, const QSize& requestedSize)
{
//    int width = 320;
//    int height = 320;
    QString rsrcid = id; //file:///
    QImage image(rsrcid);
    QImage result;

    if (requestedSize.isValid()) {
        result = image.scaled(requestedSize, Qt::KeepAspectRatio);
    } else {
        result = image;
    }
    *size = result.size();
    return result;

}

