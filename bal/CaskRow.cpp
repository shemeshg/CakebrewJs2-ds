#include "CaskRow.h"
#include "shellcmd.h"

const QString CaskRow::getCaskroomSize(QString brewLocation, QString terminalApp)
{
    if (!isInstalled) {
        return "";
    }

    if (m_caskroomSize.isEmpty()) {
        ShellCmd sc{brewLocation, terminalApp};
        m_caskroomSize = sc.cmdGetCaskroomSize(token).stdOut.simplified();
    }

    return m_caskroomSize;
}
