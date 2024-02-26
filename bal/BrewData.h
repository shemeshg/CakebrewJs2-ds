#pragma once

#include <QObject>
#include <QObjectComputedProperty>
#include <QQmlEngine>

/*[[[cog
import cog
from BrewData import classBrewData


cog.outl(classBrewData.getClassHeader(),
        dedent=True, trimblanklines=True)

]]] */
class BrewData : public QObject
{
    Q_OBJECT
    Q_PROPERTY(bool isDesigner READ isDesigner  CONSTANT )
    
    QML_ELEMENT
public:
    BrewData(QObject *parent = nullptr);

    
    
    bool isDesigner() const{return m_isDesigner;} 
    


signals:
    

private:
    bool m_isDesigner;
    
    void ctorClass();
};

//[[[end]]]

