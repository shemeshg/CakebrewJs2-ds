#include "FormulaRow.h"
#include "shellcmd.h"

const QString FormulaRow::getCellarSize(QString brewLocation, QString terminalApp)
{
    if (!isInstalled) {
        return "";
    }

    if (m_cellarSize.isEmpty()) {
        ShellCmd sc{brewLocation, terminalApp};
        m_cellarSize = sc.cmdGetcCellarSize(token).stdOut.simplified();
    }

    return m_cellarSize;
}
