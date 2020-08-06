#ifndef QIMAGEPROVIDER_H
#define QIMAGEPROVIDER_H

#include <QQuickImageProvider>
#include "imagedata.h"

class QtImageProvider : public QQuickImageProvider
{

public:
    QtImageProvider() : QQuickImageProvider(QQuickImageProvider::Image){}
    ~QtImageProvider() {}

    QImage requestImage(const QString &id, QSize* size, const QSize& requestedSize) override;
private:


};

#endif // QIMAGEPROVIDER_H
