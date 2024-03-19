#include "FormulaRow.h"
#include "shellcmd.h"

const QString FormulaRow::getCellarSize()
{
    if (!isInstalled) {
        return "";
    }

    if (m_cellarSize.isEmpty()) {
        ShellCmd sc;
        m_cellarSize = sc.cmdGetcCellarSize(token).stdOut.simplified();
    }

    return m_cellarSize;
}
