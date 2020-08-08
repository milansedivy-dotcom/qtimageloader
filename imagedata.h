#ifndef IMAGEDATA_H
#define IMAGEDATA_H

#include <QObject>
#include <QString>
#include <QRegularExpression>

class ImageData : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QString imageSource READ imageSource WRITE setImage NOTIFY imageSourceChanged)
    Q_PROPERTY(QString imageId READ imageId CONSTANT)
    Q_PROPERTY(int currentRotation READ currentRotation WRITE setCurrentRotation)

public:
    ImageData(QObject *parent = nullptr);
    ImageData(QString imageSource, QString imageId);
    ImageData(QString imageSource);
    ~ImageData();
//predelat na constat i imageSource (setter) a z setImage udelat public slot
    void setImage(QString imageSource, QString imageId = NULL);
    QString imageSource();
    QString imageId();
    int currentRotation();
    void setCurrentRotation(int);


signals:
    void imageSourceChanged();

private:
    int m_currentRotation;
    QString m_imageId;
    QString m_imageSource;

    void setImageId();
};

#endif // IMAGEDATA_H
