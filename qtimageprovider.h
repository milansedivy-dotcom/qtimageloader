#ifndef QIMAGEPROVIDER_H
#define QIMAGEPROVIDER_H

#include <QQuickImageProvider>

class QtImageProvider : public QQuickImageProvider
{
public:
    QtImageProvider() : QQuickImageProvider(QQuickImageProvider::Image){}
    ~QtImageProvider() {}

    QImage requestImage(const QString &id, QSize* size, const QSize& requestedSize) override;

};

#endif // QIMAGEPROVIDER_H
