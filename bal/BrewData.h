#pragma once

#include <QObject>
#include <QObjectComputedProperty>
#include <QQmlEngine>
#include "JsAsync.h"

/*[[[cog
import cog
from BrewData import classBrewData


cog.outl(classBrewData.getClassHeader(),
        dedent=True, trimblanklines=True)

]]] */
class BrewDataPrivate : public JsAsync
{
    Q_OBJECT
    Q_PROPERTY(bool isDesigner READ isDesigner  CONSTANT )
    
    QML_ELEMENT
public:
    BrewDataPrivate(QObject *parent = nullptr);

    
    
    bool isDesigner() const{return m_isDesigner;} 
    


signals:
    

private:
    bool m_isDesigner;
    
    void ctorClass();
};

//[[[end]]]

class BrewData : public BrewDataPrivate

{
    Q_OBJECT
    QML_ELEMENT
public:
    explicit BrewData(QObject *parent = nullptr)
        : BrewDataPrivate{parent}
    {}
};
