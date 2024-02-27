#pragma once
#include "BrewDataPrivate.h"

class BrewData : public BrewDataPrivate

{
    Q_OBJECT
    QML_ELEMENT
public:
    explicit BrewData(QObject *parent = nullptr)
        : BrewDataPrivate{parent}
    {
        QVector<GridCell *> *cask = &caskBodyList();
        GridCell *gc;
        gc = new GridCell();
        gc->setCellType("linkBtn");
        gc->setCellText("anaconda");
        gc->setFillWidth(false);
        gc->setFilterString("anaconda");
        cask->push_back(gc);

        gc = new GridCell();
        gc->setCellType("text");
        gc->setCellText(
            "Distribution of the Python and R programming languages for scientific computing");
        gc->setFillWidth(true);
        gc->setFilterString("anaconda");
        cask->push_back(gc);

        gc = new GridCell();
        gc->setCellType("text");
        gc->setCellText("homebrew/tap");
        gc->setFillWidth(false);
        gc->setFilterString("anaconda");
        cask->push_back(gc);

        gc = new GridCell();
        gc->setCellType("text");
        gc->setCellText("1.3.5");
        gc->setFillWidth(false);
        gc->setFilterString("anaconda");
        cask->push_back(gc);

        gc = new GridCell();
        gc->setCellType("checkbox");
        gc->setCellText("1.3.6");
        gc->setFillWidth(false);
        gc->setFilterString("anaconda");
        gc->setOnToggled("anaconda");
        cask->push_back(gc);

        emit caskBodyListChanged();

        QVector<GridCell *> *formula = &formulaBodyList();

        gc = new GridCell();
        gc->setCellType("linkBtn");
        gc->setCellText("libxext");
        gc->setFillWidth(false);
        gc->setFilterString("libxext");
        formula->push_back(gc);

        gc = new GridCell();
        gc->setCellType("text");
        gc->setCellText("X.Org: Library for common extensions to the X11 protocol");
        gc->setFillWidth(true);
        gc->setFilterString("libxext");
        formula->push_back(gc);

        gc = new GridCell();
        gc->setCellType("text");
        gc->setCellText("homebrew/tap");
        gc->setFillWidth(false);
        gc->setFilterString("libxext");
        formula->push_back(gc);

        gc = new GridCell();
        gc->setCellType("text");
        gc->setCellText("1.3.5");
        gc->setFillWidth(false);
        gc->setFilterString("libxext");
        formula->push_back(gc);

        gc = new GridCell();
        gc->setCellType("checkbox");
        gc->setCellText("1.3.6");
        gc->setFillWidth(false);
        gc->setFilterString("libxext");
        gc->setOnToggled("libxext");
        formula->push_back(gc);

        gc = new GridCell();
        gc->setCellType("text");
        gc->setCellText(".");
        gc->setFillWidth(false);
        gc->setFilterString("libxext");
        gc->setHoverText("<h3>Used in</h3><p>item 1</p><h3>Used by</h3><p>item 2</p>");
        formula->push_back(gc);
    }

public slots:
    void asyncRefreshData(const QJSValue &callback)
    {
        makeAsync<bool>(callback, [=]() {
            bool success = refreshData();
            if (success) {
                setLastUpdateDateStr("02-24 13:34");
                qDebug() << "setLast refresh date";                
            }
            return success;
        });
    }

private:
    bool refreshData() { return true; }
};
