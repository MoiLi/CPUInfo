#ifndef CPUINFO_H
#define CPUINFO_H

#include <QObject>
#include <QVariantList>
#include <QVariantMap>

class CPUInfo : public QObject
{
    Q_OBJECT
    Q_DISABLE_COPY(CPUInfo)
    Q_PROPERTY(QString source WRITE setSource)
public:
    explicit CPUInfo(QObject *parent = 0);

    void setSource(QString source);

    Q_INVOKABLE void startLoadCPUInfo();
signals:
    void dataChanged(QVariantList data);

private:
    QString mSource;
};

#endif // CPUINFO_H
