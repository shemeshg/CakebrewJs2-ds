#include "GridCell.h"

/*[[[cog
import cog
from GridCell import classGridCell


cog.outl(classGridCell.getClassCpp(),
        dedent=True, trimblanklines=True)


]]] */
 GridCell:: GridCell(QObject *parent)
    : QObject(parent)
{
    ctorClass();
}

//[[[end]]]

void GridCell::ctorClass()
{
}