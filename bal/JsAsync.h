#pragma once

#include <QJSEngine>
#include <QtConcurrent>


class JsAsync : public QObject
{
public:
    explicit JsAsync(QObject *_parent = nullptr)
        : QObject(_parent)
    { }

    template<typename T>
    void makeAsync(const QJSValue &callback, std::function<T()> func)
    {
        auto *watcher = new QFutureWatcher<T>(this);
        QObject::connect(watcher, &QFutureWatcher<T>::finished, this, [this, watcher, callback]() {
            T returnValue = watcher->result();
            QJSValue cbCopy(callback);
            QJSEngine *engine = qjsEngine(this);
            cbCopy.call(QJSValueList{engine->toScriptValue(returnValue)});
            watcher->deleteLater();
        });
        watcher->setFuture(QtConcurrent::run([=]() { return func(); }));
    }
};


