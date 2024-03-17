#pragma once
#include <QVariant>

class CaskRow
{
public:
    QString token, name, desc, tap, version, outdated, homepage, ruby_source_path;
    bool isOutdated, isInstalled;

    void addListHeader(QVariantList &formulaTableBodyList)
    {
        QMap<QString, QVariant> row;
        QMap<QString, QVariant> text;
        row["filterString"] = "";

        text = {};
        text["text"] = "Token";
        row["token"] = text;

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

        formulaTableBodyList.emplaceBack(row);
    }

    void addToList(QVariantList &caskTableBodyList)
    {
        QMap<QString, QVariant> row;
        QMap<QString, QVariant> text;
        row["filterString"] = token + "|" + desc + "|" + tap;
        text["text"] = token;
        row["token"] = QVariant::fromValue(text);

        text = {};
        text["text"] = desc;
        row["desc"] = QVariant::fromValue(text);

        text = {};
        text["text"] = tap;
        row["tap"] = QVariant::fromValue(text);

        text = {};
        text["text"] = version;
        row["version"] = QVariant::fromValue(text);

        text = {};
        if (isOutdated) {
            text["text"] = outdated;
        } else {
            text["text"] = "";
        }
        text["tsChecked"] = false;
        row["outdated"] = QVariant::fromValue(text);

        caskTableBodyList.emplaceBack(QVariant::fromValue(row));
    }
};
