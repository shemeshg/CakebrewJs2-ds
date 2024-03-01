#pragma once
#include "BrewDataPrivate.h"
#include "shellcmd.h"

class BrewData : public BrewDataPrivate

{
    Q_OBJECT
    QML_ELEMENT
public:
    explicit BrewData(QObject *parent = nullptr)
        : BrewDataPrivate{parent}
    {
        loadBrewLocation();
        loadNormalFontPointSize();

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

        QVector<GridCell *> *services = &servicesBodyList();

        gc = new GridCell();
        gc->setCellType("text");
        gc->setCellText("unbound");
        gc->setFillWidth(false);
        gc->setFilterString("unbound");
        services->push_back(gc);

        gc = new GridCell();
        gc->setCellType("text");
        gc->setCellText("none");
        gc->setFillWidth(false);
        gc->setFilterString("unbound");
        services->push_back(gc);

        gc = new GridCell();
        gc->setCellType("text");
        gc->setCellText("");
        gc->setFillWidth(false);
        gc->setFilterString("unbound");
        services->push_back(gc);

        gc = new GridCell();
        gc->setCellType("text");
        gc->setCellText("/usr/local/opt/unbound/homebrew.mxcl.unbound.plist");
        gc->setFillWidth(true);
        gc->setFilterString("unbound");
        services->push_back(gc);

        gc = new GridCell();
        gc->setCellType("linkBtn");
        gc->setCellText("stop");
        gc->setFillWidth(false);
        gc->setFilterString("unbound");
        services->push_back(gc);

        QObject::connect(this, &BrewData::addSearchRow, this, [=](SearchResultRow *row, bool isCask) {
            QVector<SearchResultRow *> *listOfSearchResultRows;
            if (isCask) {
                listOfSearchResultRows = &searchItemsCask();
            } else {
                listOfSearchResultRows = &searchItemsFormula();
            }
            SearchResultRow *newRow = new SearchResultRow();
            newRow->setToken(row->token());
            newRow->setName(row->name());
            newRow->setVersion(row->version());
            newRow->setHomepage(row->homepage());
            newRow->setDesc(row->desc());
            newRow->setInstalled(row->installed());
            listOfSearchResultRows->push_back(newRow);
            delete row;
        });
    }

signals:
    void addSearchRow(SearchResultRow *row, bool isCask);

public slots:
    void asyncSearch(const QJSValue &callback, QString textSearch, bool isCask)
    {
        QVector<SearchResultRow *> *listOfSearchResultRows;
        if (isCask) {
            listOfSearchResultRows = &searchItemsCask();

            qDeleteAll(*listOfSearchResultRows);
            listOfSearchResultRows->clear();
            setSearchStatusCaskText("Search Casks");
            setSearchStatusCaskVisible(true);
            setSearchCaskRunning(true);

        } else {
            listOfSearchResultRows = &searchItemsFormula();

            qDeleteAll(*listOfSearchResultRows);
            listOfSearchResultRows->clear();
            setSearchStatusFormulaText("Search Formula");
            setSearchStatusFormulaVisible(true);
            setSearchFormulaRunning(true);
        }

        makeAsync<bool>(callback, [=]() {
            ShellCmd sc;
            ProcessStatus s = sc.cmdSearch(textSearch, isCask);
            if (s.isSuccess
                //&& s.stdErr.isEmpty()
                && !s.stdOut.isEmpty()) {
                QVector<SearchResultRow *> parseCmdSearch = sc.ParseCmdSearch(s.stdOut, isCask);

                for (auto row : parseCmdSearch) {
                    emit addSearchRow(row, isCask);
                }

                parseCmdSearch.clear();
                if (isCask) {
                    emit searchItemsCaskChanged();
                    setSearchStatusCaskText(s.stdErr);
                    setSearchStatusCaskVisible(!s.stdErr.isEmpty());
                    setSearchCaskRunning(false);

                } else {
                    emit searchItemsFormulaChanged();
                    setSearchStatusFormulaText(s.stdErr);
                    setSearchStatusFormulaVisible(!s.stdErr.isEmpty());
                    setSearchFormulaRunning(false);
                }

            } else {
                if (isCask) {
                    emit searchItemsCaskChanged();
                    setSearchStatusCaskText(s.stdErr);
                    setSearchStatusCaskVisible(true);
                    setSearchCaskRunning(false);
                } else {
                    emit searchItemsFormulaChanged();
                    setSearchStatusFormulaText(s.stdErr);
                    setSearchStatusFormulaVisible(true);
                    setSearchFormulaRunning(false);
                }
            }

            return true;
        });
    }

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

    void saveNormalFontPointSize(const QString s)
    {
        settings.setValue("normalFontPointSize", s);
        loadNormalFontPointSize();
    }

    void saveBrewLocation(const QString s)
    {
        settings.setValue("brewLocation", s);
        loadBrewLocation();
    }

private:
    QSettings settings{"shemeshg", "Cakebrewjs2"};
    bool refreshData()
    {
        ShellCmd sc;
        ProcessStatus s = sc.cmdSearch("aarch64-elf-binutils", false);
        if (s.isSuccess && s.stdErr.isEmpty() && !s.stdOut.isEmpty()) {
            sc.ParseCmdSearch(s.stdOut, false);
        } else {
            //set err stderr
            //dont need return, set relevant bindable var
        }

        return true;
    }

    const QString getFindExecutable(const QString &exec) const
    {
        auto full_path = QStandardPaths::findExecutable(exec);
        if (full_path.isEmpty()) {
            full_path = QStandardPaths::findExecutable(exec,
                                                       {"/usr/local/bin", "/opt/homebrew/bin"});
        }

        return full_path;
    }

    void loadNormalFontPointSize(){
        QString s=settings.value("normalFontPointSize", "").toString();
        setNormalFontPointSize(s);
    }
    void loadBrewLocation()
    {
        QString s_brewLocation = settings.value("brewLocation", "").toString();

        QFileInfo check_file(s_brewLocation);
        if (s_brewLocation.isEmpty() || !check_file.exists()) {
            s_brewLocation = getFindExecutable("brew");
            settings.setValue("brewLocation", s_brewLocation);
        }

        setBrewLocation(s_brewLocation);
        emit brewLocationChanged();
    }
};
