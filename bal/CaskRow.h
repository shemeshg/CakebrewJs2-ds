#pragma once
#include "GridCell.h"

class CaskRow
{
public:
    QString token, desc, tap, version, outdated;
    bool isOutdated;
    void addToList(QVector<GridCell *> *cask)
    {
        GridCell *gc;

        QString filterString = token + "|" + desc + "|" + tap;

        gc = new GridCell();
        gc->setCellType("linkBtn");
        gc->setCellText(token);
        gc->setFillWidth(false);
        gc->setFilterString(filterString);
        cask->push_back(gc);

        gc = new GridCell();
        gc->setCellType("text");
        gc->setCellText(desc);
        gc->setFillWidth(true);
        gc->setFilterString(filterString);
        cask->push_back(gc);

        gc = new GridCell();
        gc->setCellType("text");
        gc->setCellText(tap);
        gc->setFillWidth(false);
        gc->setFilterString(filterString);
        cask->push_back(gc);

        gc = new GridCell();
        gc->setCellType("text");
        gc->setCellText(version);
        gc->setFillWidth(false);
        gc->setFilterString(filterString);
        cask->push_back(gc);

        gc = new GridCell();
        if (isOutdated) {
            gc->setCellType("checkbox");
            gc->setCellText(outdated);
            gc->setFillWidth(false);
            gc->setFilterString(filterString);
            gc->setOnToggled(token);
            cask->push_back(gc);
        } else {
            gc->setCellType("text");
            gc->setCellText("");
            gc->setFillWidth(false);
            gc->setFilterString(filterString);
            cask->push_back(gc);
        }
    }
};
