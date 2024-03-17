#pragma once
#include "BrewDataPrivate.h"
#include "CaskRow.h"
#include "FormulaRow.h"
#include "ServiceRow.h"
#include "shellcmd.h"

class BrewData : public BrewDataPrivate

{
    Q_OBJECT
    QML_ELEMENT
public:
    enum class InfoStatus {
        Idile,
        Running,
        CaskFound,
        FormulaFound,
        CaskNotFound,
        FormulaNotFound
    };
    Q_ENUM(InfoStatus)

    explicit BrewData(QObject *parent = nullptr)
        : BrewDataPrivate{parent}
    {
        loadBrewLocation();
        loadNormalFontPointSize();
        loadTerminalApp();

        CaskRow cr{};
        cr.addListHeader(caskTableBodyList());

        cr.token = "anaconda";
        cr.desc = "anaconda analitical framework";
        cr.tap = "tap/homebrew";
        cr.version = "1,01";
        cr.outdated = "2.03";
        cr.addToList(caskTableBodyList());
        emit caskTableBodyListChanged();

        FormulaRow fr{};
        fr.addListHeader(formulaTableBodyList());

        fr.token = "electron";
        fr.desc = "electron software whatever applications";
        fr.tap = "homebrew/tap";
        fr.isOutdated = true;
        fr.version = "0.03";
        fr.outdated = "1.02";
        fr.leafText = ".";
        fr.leafPopup = "<h3>Used in</h3><p>item 1</p><h3>Used by</h3><p>item 2</p>";
        fr.addToList(formulaTableBodyList());
        emit formulaTableBodyListChanged();

        ServiceRow serviceRow{};
        serviceRow.addListHeader(serviceTableBodyList());

        serviceRow.name = "unbound";
        serviceRow.status = "none";
        serviceRow.user = "";
        serviceRow.plist = "/usr/local/opt/unbound/homebrew.mxcl.unbound.plist";
        serviceRow.action = "start";
        serviceRow.addToList(serviceTableBodyList());
        emit serviceTableBodyListChanged();

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

        QObject::connect(this,
                         &BrewData::parseRefreshServicesSignal,
                         this,
                         &BrewData::parseRefreshServices);

        QObject::connect(this,
                         &BrewData::parseRefreshCaskAndFormulaSignal,
                         this,
                         &BrewData::parseRefreshCaskAndFormula);
    }

signals:
    void addSearchRow(SearchResultRow *row, bool isCask);
    void parseRefreshServicesSignal(QString strResult);
    void parseRefreshCaskAndFormulaSignal(QString strResult);

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
                && !s.stdOut.isEmpty()) {
                QVector<SearchResultRow *> parseCmdSearch = sc.parseCmdSearch(s.stdOut, isCask);

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

    void asyncServiceAction(const QJSValue &callback, QString name, QString action)
    {
        refreshServicesBeforeCallback();
        makeAsync<bool>(callback, [=]() {
            ShellCmd sc;
            QString cmd = "%1 services '%2' '%3'";
            cmd = cmd.arg("/usr/local/bin/brew", action, name);
            sc.externalTerminalCmd(cmd);
            refreshServicesAfterCallback();
            return true;
        });
    }

    void asyncRefreshServices(const QJSValue &callback)
    {
        refreshServicesBeforeCallback();
        makeAsync<bool>(callback, [=]() {
            refreshServicesAfterCallback();
            return true;
        });
    }

    void asyncRefreshCaskAndFormula(const QJSValue &callback)
    {
        refreshCaskAndFormulaBeforeCallback();
        makeAsync<bool>(callback, [=]() {
            refreshCaskAndFormulaAfterCallback();
            return true;
        });
    }

    void saveTerminalApp(const QString s)
    {
        settings.setValue("terminalApp", s);
        loadTerminalApp();
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

    void asyncFormulaSort(const QJSValue &callback)
    {
        makeAsync<bool>(callback, [=]() {
            formulaSort();
            return true;
        });
    }

    void formulaSort()
    {
        std::sort(formulaRows.begin(), formulaRows.end(), [=](FormulaRow &a, FormulaRow &b) {
            QString aOutdated = "_";
            QString bOutdated = "_";
            if (a.isOutdated) {
                aOutdated = "_" + a.token;
            } else {
                aOutdated = a.token;
            }
            if (b.isOutdated) {
                bOutdated = "_" + b.token;
            } else {
                bOutdated = b.token;
            }
            if (formulaSortedColIdx() == 4 && formulaSortedColOrder() == 2) {
                return aOutdated > bOutdated;
            }

            if (formulaSortedColIdx() == 5) {
                if (formulaSortedColOrder() == 1) {
                    return a.leafText + a.token < b.leafText + b.token;
                } else if (formulaSortedColOrder() == 2) {
                    return a.leafText + a.token > b.leafText + b.token;
                }
            }

            if (formulaSortedColIdx() == 3) {
                if (formulaSortedColOrder() == 1) {
                    return a.version < b.version;
                } else if (formulaSortedColOrder() == 2) {
                    return a.version > b.version;
                }
            }

            if (formulaSortedColIdx() == 2) {
                if (formulaSortedColOrder() == 1) {
                    return a.tap + a.token < b.tap + b.token;
                } else if (formulaSortedColOrder() == 2) {
                    return a.tap + a.token > b.tap + b.token;
                }
            }

            if (formulaSortedColIdx() == 1) {
                if (formulaSortedColOrder() == 1) {
                    return a.desc < b.desc;
                } else if (formulaSortedColOrder() == 2) {
                    return a.desc > b.desc;
                }
            }

            if (formulaSortedColIdx() == 0) {
                if (formulaSortedColOrder() == 1) {
                    return a.token < b.token;
                } else if (formulaSortedColOrder() == 2) {
                    return a.token > b.token;
                }
            }

            return aOutdated < bOutdated;
        });

        formulaTableBodyList().clear();
        FormulaRow fr{};
        fr.addListHeader(formulaTableBodyList());

        for (FormulaRow &r : formulaRows) {
            r.addToList(formulaTableBodyList());
        }

        emit formulaTableBodyListChanged();
    }

    void asyncCaskSort(const QJSValue &callback)
    {
        makeAsync<bool>(callback, [=]() {
            caskSort();
            return true;
        });
    }

    void caskSort()
    {
        std::sort(caskRows.begin(), caskRows.end(), [=](CaskRow &a, CaskRow &b) {
            if (caskSortedColIdx() == 4 && caskSortedColOrder() == 1) {
                return a.outdated + a.token < b.outdated + b.token;
            }

            if (caskSortedColIdx() == 0) {
                if (caskSortedColOrder() == 1) {
                    return a.token < b.token;
                } else if (caskSortedColOrder() == 2) {
                    return a.token > b.token;
                }
            }

            if (caskSortedColIdx() == 1) {
                if (caskSortedColOrder() == 1) {
                    return a.desc < b.desc;
                } else if (caskSortedColOrder() == 2) {
                    return a.desc > b.desc;
                }
            }

            if (caskSortedColIdx() == 2) {
                if (caskSortedColOrder() == 1) {
                    return a.tap + a.token < b.tap + b.token;
                } else if (caskSortedColOrder() == 2) {
                    return a.tap + a.token > b.tap + b.token;
                }
            }

            if (caskSortedColIdx() == 3) {
                if (caskSortedColOrder() == 1) {
                    return a.version < b.version;
                } else if (caskSortedColOrder() == 2) {
                    return a.version > b.version;
                }
            }

            return a.outdated + a.token < b.outdated + b.token;
        });

        caskTableBodyList().clear();
        CaskRow fr{};
        fr.addListHeader(caskTableBodyList());

        for (CaskRow &r : caskRows) {
            r.addToList(caskTableBodyList());
        }

        emit caskTableBodyListChanged();
    }

    void asyncGetInfo(QString token, bool isCask, const QJSValue &callback)
    {
        makeAsync<QVariant>(callback, [=]() { return getInfo(token, isCask); });
    }

    QVariant getInfo(const QString token, bool isCask)
    {
        QMap<QString, QVariant> row;
        ShellCmd sc;
        ProcessStatus s = sc.cmdGetInfo(token, isCask);

        if (s.isSuccess && !s.stdOut.isEmpty()) {
            if (isCask) {
                CaskRow caskRow = sc.parseCaskList(s.stdOut).at(0);
                row["infoStatus"] = (int) InfoStatus::CaskFound;
                row["token"] = caskRow.token;
                row["desc"] = caskRow.desc;
                row["tap"] = caskRow.tap;
                row["version"] = caskRow.version;
                row["outdated"] = caskRow.outdated;
                row["isOutdated"] = caskRow.isOutdated;
                row["isInstalled"] = caskRow.isInstalled;
                row["name"] = caskRow.name;
                row["homepage"] = caskRow.homepage;
                row["ruby_source_path"] = caskRow.ruby_source_path;
            } else {
                FormulaRow formulaRow = sc.parseFormulaList(s.stdOut).at(0);
                row["infoStatus"] = (int) InfoStatus::FormulaFound;
                row["token"] = formulaRow.token;
                row["desc"] = formulaRow.desc;
                row["tap"] = formulaRow.tap;
                row["version"] = formulaRow.version;
                row["outdated"] = formulaRow.outdated;
                row["leafText"] = formulaRow.leafText;
                row["isOutdated"] = formulaRow.isOutdated;
                row["installedOnRequest"] = formulaRow.installedOnRequest;
                row["usedIn"] = formulaRow.usedIn;
            }
        } else {
            if (s.stdErr.isEmpty()) {
                s.stdErr = "Err" + QString::number(s.exitCode);
            }
            row["infoStatus"] = isCask ? (int) InfoStatus::CaskNotFound
                                       : (int) InfoStatus::FormulaNotFound;            
        }
        row["err"] = s.stdErr;
        return row;
    }

    void asyncServiceSort(const QJSValue &callback)
    {
        makeAsync<bool>(callback, [=]() {
            serviceSort();
            return true;
        });
    }

    void serviceSort()
    {
        std::sort(serviceRows.begin(), serviceRows.end(), [=](ServiceRow &a, ServiceRow &b) {
            if (serviceSortedColIdx() == 0 && serviceSortedColOrder() == 1) {
                return a.name < b.name;
            }

            if (serviceSortedColIdx() == 1) {
                if (serviceSortedColOrder() == 1) {
                    return a.status + a.name < b.status + a.name;
                } else if (serviceSortedColOrder() == 2) {
                    return a.status + a.name > b.status + a.name;
                }
            }

            if (serviceSortedColIdx() == 2) {
                if (serviceSortedColOrder() == 1) {
                    return a.user + a.name < b.user + a.name;
                } else if (serviceSortedColOrder() == 2) {
                    return a.user + a.name > b.user + a.name;
                }
            }

            if (serviceSortedColIdx() == 3) {
                if (serviceSortedColOrder() == 1) {
                    return a.plist < b.plist;
                } else if (serviceSortedColOrder() == 2) {
                    return a.plist > b.plist;
                }
            }

            if (serviceSortedColIdx() == 4) {
                if (serviceSortedColOrder() == 1) {
                    return a.action + a.name < b.action + a.name;
                } else if (serviceSortedColOrder() == 2) {
                    return a.action + a.name > b.action + a.name;
                }
            }

            return a.name > b.name;
        });
        serviceTableBodyList().clear();
        ServiceRow fr{};
        fr.addListHeader(serviceTableBodyList());

        for (ServiceRow &r : serviceRows) {
            r.addToList(serviceTableBodyList());
        }

        emit serviceTableBodyListChanged();
    }

private slots:
    void parseRefreshServices(QString strResult)
    {
        ShellCmd sc;
        serviceRows = sc.parseServicesList(strResult);
        serviceSort();
    }

    void parseRefreshCaskAndFormula(QString strResult)
    {
        ShellCmd sc;
        caskRows = sc.parseCaskList(strResult);
        formulaRows = sc.parseFormulaList(strResult);
        caskSort();
        formulaSort();
    }

private:
    QSettings settings{"shemeshg", "Cakebrewjs2"};

    QVector<ServiceRow> serviceRows;
    QVector<CaskRow> caskRows;
    QVector<FormulaRow> formulaRows;

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

    void loadTerminalApp()
    {
        QString s = settings.value("terminalApp", "iTerm").toString();
        setTerminalApp(s);
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

    void refreshCaskAndFormulaBeforeCallback()
    {
        setRefreshStatusFormulaText("Refresh formula");
        setRefreshStatusFormulaVisible(true);
        setRefreshFormulaRunning(true);

        setRefreshStatusCaskText("Refresh cask");
        setRefreshStatusCaskVisible(true);
        setRefreshCaskRunning(true);
    }

    void refreshCaskAndFormulaAfterCallback()
    {
        //brew outdated --json=v2
        ShellCmd sc;
        ProcessStatus s = sc.cmdListCaskAndFormula();

        if (s.isSuccess && !s.stdOut.isEmpty()) {
            emit parseRefreshCaskAndFormulaSignal(s.stdOut);
        } else {
            if (s.stdErr.isEmpty()) {
                s.stdErr = "Err" + QString::number(s.exitCode);
            }
        }
        if (!s.stdErr.isEmpty()) {
            setRefreshStatusFormulaText(s.stdErr);
            setRefreshStatusCaskText(s.stdErr);
            setRefreshStatusFormulaVisible(true);
            setRefreshStatusCaskVisible(true);
        } else {
            setRefreshStatusFormulaVisible(false);
            setRefreshStatusCaskVisible(false);
        }
        setRefreshFormulaRunning(false);
        setRefreshCaskRunning(false);
    }

    void refreshServicesBeforeCallback()
    {
        setRefreshStatusServiceText("Refresh services");
        setRefreshStatusServiceVisible(true);
        setRefreshServiceRunning(true);
    }

    void refreshServicesAfterCallback()
    {
        ShellCmd sc;
        ProcessStatus s = sc.cmdListServices();

        if (s.isSuccess && !s.stdOut.isEmpty()) {
            emit parseRefreshServicesSignal(s.stdOut);
        } else {
            if (s.stdErr.isEmpty()) {
                s.stdErr = "Err" + QString::number(s.exitCode);
            }
        }
        if (!s.stdErr.isEmpty()) {
            setRefreshStatusServiceText(s.stdErr);
            setRefreshStatusServiceVisible(true);
        } else {
            setRefreshStatusServiceVisible(false);
        }
        setRefreshServiceRunning(false);
    }
};
