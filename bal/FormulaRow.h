#pragma once
#include "GridCell.h"

class FormulaRow
{
public:
    QString token, desc, tap, version, outdated, leafText, leafPopup;
    bool isOutdated;
    QStringList usedIn;
    void addToList(QVector<GridCell *> *formula)
    {
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
        } else {
            leafText = "*";
        }
        gc = new GridCell();
        gc->setCellType("text");
        gc->setCellText(leafText);
        gc->setFillWidth(false);
        gc->setFilterString(filterString);
        gc->setHoverText(leafPopup);
        formula->push_back(gc);
    }
};
