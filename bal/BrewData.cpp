#include "BrewData.h"

/*[[[cog
import cog
from BrewData import classBrewData


cog.outl(classBrewData.getClassCpp(),
        dedent=True, trimblanklines=True)


]]] */
 BrewDataPrivate:: BrewDataPrivate(QObject *parent)
    : JsAsync(parent)
{
    ctorClass();
}

//[[[end]]]

void BrewDataPrivate::ctorClass()
{
    m_isDesigner = false;
}
