#ifndef IMAGERESOURCES_H
#define IMAGERESOURCES_H

#include <QObject>
#include <QVector>
#include <QVariant>
#include <QQmlListProperty>
#include <QAbstractListModel>
#include "imagedata.h"



class ImageResources : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QQmlListProperty<ImageData> sourceFiles READ sourceFiles NOTIFY listChanged)

public:
    ImageResources(QObject *parent = nullptr);
    ~ImageResources();

    QQmlListProperty<ImageData> sourceFiles();
//    int rowCount(const QModelIndex &parent = QModelIndex()) const;
//    QVariant data(const QModelIndex &index, int role = Qt::DisplayRole) const;

public slots:
    void appendImage(QString);
    void deleteImage(int);
    void deleteAll();
    //ImageData* imageData(int) const;

signals:
    void listChanged();

private:
    ImageData *m_newData;
    QList<ImageData*> m_imageSourceList;
    //static void appendImage(QQmlListProperty<ImageData>*, ImageData*);
    //static ImageData* imageData(QQmlListProperty<ImageData>*, int);
};

#endif // IMAGERESOURCES_H
