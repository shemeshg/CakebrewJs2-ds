#pragma once
#include <QMap>
#include "GridCell.h"

class FormulaRow
{
public:
    QString token, desc, tap, version, outdated, leafText, leafPopup;
    bool isOutdated, installedOnRequest;
    QStringList usedIn;
    void addListHeader(QVariantList &formulaTableBodyList)
    {
        QMap<QString, QVariant> row;
        QMap<QString, QVariant> text;
        row["filterString"] = "";

        text = {};
        text["text"] = "Name";
        row["name"] = QVariant::fromValue(text);

        text = {};
        text["text"] = "Description";
        row["desc"] = QVariant::fromValue(text);

        text = {};
        text["text"] = "Tap";
        row["tap"] = QVariant::fromValue(text);

        text = {};
        text["text"] = "Version";
        row["version"] = QVariant::fromValue(text);

        text = {};
        text["text"] = "Outdated";
        row["outdated"] = QVariant::fromValue(text);

        text = {};
        text["text"] = "Leaf";
        row["leaf"] = QVariant::fromValue(text);

        formulaTableBodyList.emplaceBack(row);
    }
    void addToList(QVector<GridCell *> *formula, QVariantList &formulaTableBodyList)
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
        formulaTableBodyList.emplaceBack(row);

        GridCell *gc;
        QString filterString = token + "|" + desc + "|" + tap;

        gc = new GridCell();
        gc->setCellType("linkBtn");
        gc->setCellText(token);
        gc->setFillWidth(false);
        gc->setFilterString(filterString);
        formula->push_back(gc);

        gc = new GridCell();
        gc->setCellType("text");
        gc->setCellText(desc);
        gc->setFillWidth(true);
        gc->setFilterString(filterString);
        formula->push_back(gc);

        gc = new GridCell();
        gc->setCellType("text");
        gc->setCellText(tap);
        gc->setFillWidth(false);
        gc->setFilterString(filterString);
        formula->push_back(gc);

        gc = new GridCell();
        gc->setCellType("text");
        gc->setCellText(version);
        gc->setFillWidth(false);
        gc->setFilterString(filterString);
        formula->push_back(gc);

        gc = new GridCell();
        if (isOutdated) {
            gc->setCellType("checkbox");
            gc->setCellText(outdated);
            gc->setFillWidth(false);
            gc->setFilterString(filterString);
            gc->setOnToggled(token);
            formula->push_back(gc);
        } else {
            gc->setCellType("text");
            gc->setCellText("");
            gc->setFillWidth(false);
            gc->setFilterString(filterString);
            formula->push_back(gc);
        }

        if (usedIn.length() == 0) {
            leafText = "🍃";
        } else if (installedOnRequest) {
            leafText = "in";
            leafPopup = usedIn.join("\n");
        } else {
            leafText = "*";
            leafPopup = usedIn.join("\n");
        }
        gc = new GridCell();
        gc->setCellType("text");
        gc->setCellText(leafText);
        gc->setFillWidth(false);
        gc->setFilterString(filterString);
        gc->setHoverText(leafPopup);
        formula->push_back(gc);

        for (int i = 0; i <= 5; ++i) {
            gc = new GridCell();
            gc->setCellType("bar");
            gc->setCellText("");
            gc->setFillWidth(false);
            gc->setFilterString(filterString);
            formula->push_back(gc);
        }
    }
};
