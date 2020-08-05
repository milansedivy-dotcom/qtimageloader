#ifndef QIMAGEPROVIDER_H
#define QIMAGEPROVIDER_H

#include <QQuickImageProvider>

class QImageProvider : public QQuickImageProvider
{
public:
    QImageProvider() : QQuickImageProvider(QQuickImageProvider::QImage)
    {
    }
    ~QImageProvider();

    QImage requestImage();
};

#endif // QIMAGEPROVIDER_H
