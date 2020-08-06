#ifndef IMAGEDATA_H
#define IMAGEDATA_H

#include <QObject>
#include <QString>

class ImageData : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QString imageSource READ imageSource WRITE setImage)
    Q_PROPERTY(QString imageId READ imageId)

public:
    ImageData();
    ~ImageData() {}

    void setImage(QString imageSource, QString imageId = NULL);
    QString imageSource();
    QString imageId();

private:
    QString m_imageId;
    QString m_imageSource;

    void setImageId();
};

#endif // IMAGEDATA_H
