#ifndef IMAGERESOURCES_H
#define IMAGERESOURCES_H

#include <QObject>
#include <QVector>
#include <QVariant>
#include <QQmlListProperty>
#include <QAbstractListModel>
#include <QUrl>
#include <QDirIterator>
#include <QDebug>
#include "imagedata.h"




class ImageResources : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QQmlListProperty<ImageData> sourceFiles READ sourceFiles NOTIFY listChanged)
    Q_PROPERTY(int currentIndex READ currentIndex WRITE setCurrentIndex NOTIFY currentIndexChanged CONSTANT)

public:
    ImageResources(QObject *parent = nullptr);
    ~ImageResources();

    QQmlListProperty<ImageData> sourceFiles();
    int currentIndex();
    //    int rowCount(const QModelIndex &parent = QModelIndex()) const;
//    QVariant data(const QModelIndex &index, int role = Qt::DisplayRole) const;

public slots:
    void appendMultipleImages(const QList<QUrl> &);
    void appendImage(QString);
    void appendDirectory(QString);
    void deleteImage(int);
    void deleteAll();
    void setCurrentIndex(int);
    //ImageData* imageData(int) const;

signals:
    void listChanged();
    void currentIndexChanged(int index);

private:
    int m_currentIndex;
    ImageData *m_newData;
    QList<ImageData*> m_imageSourceList;
    //static void appendImage(QQmlListProperty<ImageData>*, ImageData*);
    //static ImageData* imageData(QQmlListProperty<ImageData>*, int);
};

#endif // IMAGERESOURCES_H
