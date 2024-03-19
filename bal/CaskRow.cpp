#include "CaskRow.h"
#include "shellcmd.h"

const QString CaskRow::getCaskroomSize()
{
    if (!isInstalled) {
        return "";
    }

    if (m_caskroomSize.isEmpty()) {
        ShellCmd sc;
        m_caskroomSize = sc.cmdGetCaskroomSize(token).stdOut.simplified();
    }

    return m_caskroomSize;
}
