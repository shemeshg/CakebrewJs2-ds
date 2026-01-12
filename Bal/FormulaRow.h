#pragma once
#include <QMap>
#include <QVariant>
#include "shellcmd.h"

class FormulaRow
{
public:
    QString token, desc, tap, tapToken, version, outdated, leafText, leafPopup, fullName, homepage,
        ruby_source_path, license, caveats;
    bool isOutdated, isPinned, installedOnRequest, isInstalled, isDeprecated;
    QStringList usedIn, dependencies, buildDependencies;
    void addListHeader(QVariantList &formulaTableBodyList);
    void addToList(QVariantList &formulaTableBodyList);

    const QString getCellarSize(ShellCmd &sc);

private:
    QString m_cellarSize;
};
