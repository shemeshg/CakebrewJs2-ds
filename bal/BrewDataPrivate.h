#pragma once

#include <QObject>
#include <QObjectComputedProperty>
#include <QQmlEngine>
#include "JsAsync.h"

/*[[[cog
import cog
from BrewDataPrivate import classBrewDataPrivate


cog.outl(classBrewDataPrivate.getClassHeader(),
        dedent=True, trimblanklines=True)

]]] */
class BrewDataPrivate : public JsAsync
{
    Q_OBJECT
    Q_PROPERTY(bool isDesigner READ isDesigner  CONSTANT )
    Q_PROPERTY(QString lastUpdateDateStr READ lastUpdateDateStr WRITE setLastUpdateDateStr NOTIFY lastUpdateDateStrChanged )
    
    QML_ELEMENT
public:
    BrewDataPrivate(QObject *parent = nullptr);

    
    
    bool isDesigner() const{return m_isDesigner;} 
    

    
    QString lastUpdateDateStr() const{return m_lastUpdateDateStr;} 
    
void setLastUpdateDateStr(const QString &newLastUpdateDateStr)
    {
        if (m_lastUpdateDateStr == newLastUpdateDateStr)
            return;
        m_lastUpdateDateStr = newLastUpdateDateStr;
        emit lastUpdateDateStrChanged();
    }



signals:
    void lastUpdateDateStrChanged();
    

private:
    bool m_isDesigner;
    QString m_lastUpdateDateStr;
    
    void ctorClass();
};

//[[[end]]]


