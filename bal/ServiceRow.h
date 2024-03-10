#pragma once

#include <QVariant>

class ServiceRow
{
public:
    QString name, status, user, plist, action;

    void addListHeader(QVariantList &formulaTableBodyList)
    {
        QMap<QString, QVariant> row;
        QMap<QString, QVariant> text;
        row["filterString"] = "";

        text = {};
        text["text"] = "Name";
        row["name"] = text;

        text = {};
        text["text"] = "Status";
        row["status"] = text;

        text = {};
        text["text"] = "User";
        row["user"] = text;

        text = {};
        text["text"] = "Plist";
        row["plist"] = text;

        text = {};
        text["text"] = "Actions";
        row["action"] = text;

        formulaTableBodyList.emplaceBack(row);
    }

    void addToList(QVariantList &serviceTableBodyList)
    {
        QMap<QString, QVariant> row;
        QMap<QString, QVariant> text;
        row["filterString"] = name;
        text["text"] = name;
        row["name"] = QVariant::fromValue(text);

        text = {};
        text["text"] = status;
        row["status"] = QVariant::fromValue(text);

        text = {};
        text["text"] = user;
        row["user"] = QVariant::fromValue(text);

        text = {};
        text["text"] = plist;
        row["plist"] = QVariant::fromValue(text);

        text = {};
        text["text"] = action;
        text["name"] = name;
        row["action"] = QVariant::fromValue(text);

        serviceTableBodyList.emplaceBack(row);
    }
};
