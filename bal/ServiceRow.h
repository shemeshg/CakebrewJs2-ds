#pragma once

#include <QVariant>

class ServiceRow
{
public:
    QString name, status, user, plist, action;

    void addListHeader(QVariantList &formulaTableBodyList);

    void addToList(QVariantList &serviceTableBodyList);
};
