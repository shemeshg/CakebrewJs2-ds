#include "searchresultrow.h"

/*[[[cog
import cog
from SearchResultRow import classSearchResultRow


cog.outl(classSearchResultRow.getClassCpp(),
        dedent=True, trimblanklines=True)


]]] */
 SearchResultRow:: SearchResultRow(QObject *parent)
    : QObject(parent)
{
    ctorClass();
}

//[[[end]]]

void SearchResultRow::ctorClass() {}
