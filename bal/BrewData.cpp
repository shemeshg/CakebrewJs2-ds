#include "BrewData.h"

/*[[[cog
import cog
from BrewData import classBrewData


cog.outl(classBrewData.getClassCpp(),
        dedent=True, trimblanklines=True)


]]] */
 BrewData:: BrewData(QObject *parent)
    : QObject(parent)
{
    ctorClass();
}

//[[[end]]]


void BrewData::ctorClass() {
        m_isDesigner = false;
}
