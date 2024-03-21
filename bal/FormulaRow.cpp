#include "FormulaRow.h"
#include "shellcmd.h"

void FormulaRow::addListHeader(QVariantList &formulaTableBodyList)
{
    QMap<QString, QVariant> row;
    QMap<QString, QVariant> text;
    row["filterString"] = "";

    text = {};
    text["text"] = "Name";
    row["name"] = text;

    text = {};
    text["text"] = "Description";
    row["desc"] = text;

    text = {};
    text["text"] = "Tap";
    row["tap"] = text;

    text = {};
    text["text"] = "Version";
    row["version"] = text;

    text = {};
    text["text"] = "Outdated";
    row["outdated"] = text;

    text = {};
    text["text"] = "Leaf";
    row["leaf"] = text;

    formulaTableBodyList.emplaceBack(row);
}

void FormulaRow::addToList(QVariantList &formulaTableBodyList)
{
    QMap<QString, QVariant> row;
    QMap<QString, QVariant> text;
    row["filterString"] = token + "|" + desc + "|" + tap;
    text["text"] = token;
    row["name"] = QVariant::fromValue(text);

    text = {};
    text["text"] = desc;
    row["desc"] = QVariant::fromValue(text);

    text = {};
    text["text"] = tap;
    row["tap"] = QVariant::fromValue(text);

    text = {};
    if (isPinned) {
        text["text"] = "📌 " + version;
    } else {
        text["text"] = version;
    }
    row["version"] = QVariant::fromValue(text);

    text = {};
    if (isOutdated) {
        text["text"] = outdated;
    } else {
        text["text"] = "";
    }
    text["tsChecked"] = false;
    row["outdated"] = QVariant::fromValue(text);

    if (usedIn.length() == 0) {
        leafText = "🍃";
    } else if (installedOnRequest) {
        leafText = "in";
        leafPopup = usedIn.join("\n");
    } else {
        leafText = "*";
        leafPopup = usedIn.join("\n");
    }

    text = {};
    text["text"] = leafText;
    text["hoverText"] = leafPopup;
    row["leaf"] = QVariant::fromValue(text);
    formulaTableBodyList.emplaceBack(QVariant::fromValue(row));
}

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
