#include "BrewDataPrivate.h"

/*[[[cog
import cog
from BrewDataPrivate import classBrewDataPrivate


cog.outl(classBrewDataPrivate.getClassCpp(),
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
    m_lastUpdateDateStr = "never";
}
