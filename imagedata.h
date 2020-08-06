#ifndef IMAGEDATA_H
#define IMAGEDATA_H

#include <QObject>
#include <QString>

class ImageData : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QString imageSource READ imageSource WRITE setImageSource)
    Q_PROPERTY(QString imageId READ imageId)

public:
    ImageData();
    ~ImageData() {}

    void setImageSource(QString imageSource);
    QString imageSource();
    QString imageId();

private:
    QString m_imageId;
    QString m_imageSource;

    void setImageId();
};

#endif // IMAGEDATA_H
