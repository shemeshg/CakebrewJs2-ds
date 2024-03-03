#pragma once
#include "GridCell.h"

class FormulaRow
{
public:
    QString token, desc, tap, version, outdated, leafText, leafPopup;
    void addToList(QVector<GridCell *> *formula)
    {
        GridCell *gc;
        gc = new GridCell();
        gc->setCellType("linkBtn");
        gc->setCellText(token);
        gc->setFillWidth(false);
        gc->setFilterString(token);
        formula->push_back(gc);

        gc = new GridCell();
        gc->setCellType("text");
        gc->setCellText(desc);
        gc->setFillWidth(true);
        gc->setFilterString(token);
        formula->push_back(gc);

        gc = new GridCell();
        gc->setCellType("text");
        gc->setCellText(tap);
        gc->setFillWidth(false);
        gc->setFilterString(token);
        formula->push_back(gc);

        gc = new GridCell();
        gc->setCellType("text");
        gc->setCellText(version);
        gc->setFillWidth(false);
        gc->setFilterString(token);
        formula->push_back(gc);

        gc = new GridCell();
        gc->setCellType("checkbox");
        gc->setCellText(outdated);
        gc->setFillWidth(false);
        gc->setFilterString(token);
        gc->setOnToggled(token);
        formula->push_back(gc);

        gc = new GridCell();
        gc->setCellType("text");
        gc->setCellText(leafText);
        gc->setFillWidth(false);
        gc->setFilterString("libxext");
        gc->setHoverText(leafPopup);
        formula->push_back(gc);
    }
};
