#pragma once
#include <QVariant>
#include "shellcmd.h"

class CaskRow
{
public:
    QString token, name, desc, tap, tapToken, version, outdated, homepage, ruby_source_path, artifacts,
        caveats;
    bool isOutdated, isInstalled, isDeprecated;

    void addListHeader(QVariantList &formulaTableBodyList);

    void addToList(QVariantList &caskTableBodyList);

    const QString getCaskroomSize(ShellCmd &sc);

private:
    QString m_caskroomSize;
};
