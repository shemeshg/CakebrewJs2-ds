#pragma once

#include "GridCell.h"

class ServiceRow
{
public:
    QString name, status, user, plist, action;
    void addToList(QVector<GridCell *> *services)
    {
        GridCell *gc;
        gc = new GridCell();
        gc->setCellType("text");
        gc->setCellText(name);
        gc->setFillWidth(false);
        gc->setFilterString(name);
        services->push_back(gc);

        gc = new GridCell();
        gc->setCellType("text");
        gc->setCellText(status);
        gc->setFillWidth(false);
        gc->setFilterString(name);
        services->push_back(gc);

        gc = new GridCell();
        gc->setCellType("text");
        gc->setCellText(user);
        gc->setFillWidth(false);
        gc->setFilterString(name);
        services->push_back(gc);

        gc = new GridCell();
        gc->setCellType("text");
        gc->setCellText(plist);
        gc->setFillWidth(true);
        gc->setFilterString(name);
        services->push_back(gc);

        gc = new GridCell();
        gc->setCellType("linkBtn");
        gc->setCellText(action);
        gc->setFillWidth(false);
        gc->setFilterString(name);
        services->push_back(gc);
    }
};
