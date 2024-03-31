#pragma once
#include <QVariant>
#include "shellcmd.h"

class CaskRow
{
public:
    QString token, name, desc, tap, version, outdated, homepage, ruby_source_path, artifacts;
    bool isOutdated, isInstalled, isDeprecated;

    void addListHeader(QVariantList &formulaTableBodyList);

    void addToList(QVariantList &caskTableBodyList);

    const QString getCaskroomSize(ShellCmd &sc);

private:
    QString m_caskroomSize;
};
