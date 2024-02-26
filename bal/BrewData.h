#pragma once
#include "BrewDataPrivate.h"

class BrewData : public BrewDataPrivate

{
    Q_OBJECT
    QML_ELEMENT
public:
    explicit BrewData(QObject *parent = nullptr)
        : BrewDataPrivate{parent}
    {}

public slots:
    void asyncRefreshData(const QJSValue &callback)
    {
        makeAsync<bool>(callback, [=]() {
            bool success = refreshData();
            if (success) {
                qDebug() << "setLast refresh date";
            }
            return success;
        });
    }

private:
    bool refreshData() { return true; }
};
