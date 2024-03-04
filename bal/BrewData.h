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
    explicit BrewData(QObject *parent = nullptr)
        : BrewDataPrivate{parent}
    {
        loadBrewLocation();
        loadNormalFontPointSize();
        loadTerminalApp();

        QVector<GridCell *> *cask = &caskBodyList();
        qDeleteAll(*cask);
        cask->clear();
        CaskRow cr{};
        cr.token = "anaconda";
        cr.desc = "anaconda analitical framework";
        cr.tap = "tap/homebrew";
        cr.version = "1,01";
        cr.outdated = "2.03";
        cr.addToList(cask);
        emit caskBodyListChanged();

        QVector<GridCell *> *formula = &formulaBodyList();
        qDeleteAll(*formula);
        formula->clear();
        FormulaRow fr{};
        fr.token = "electron";
        fr.desc = "electron software whatever applications";
        fr.tap = "homebrew/tap";
        fr.version = "0.03";
        fr.outdated = "1.02";
        fr.leafText = ".";
        fr.leafPopup = "<h3>Used in</h3><p>item 1</p><h3>Used by</h3><p>item 2</p>";
        fr.addToList(formula);
        emit formulaBodyListChanged();

        QVector<GridCell *> *services = &servicesBodyList();
        qDeleteAll(*services);
        services->clear();
        ServiceRow serviceRow{};
        serviceRow.name = "unbound";
        serviceRow.status = "none";
        serviceRow.user = "";
        serviceRow.plist = "/usr/local/opt/unbound/homebrew.mxcl.unbound.plist";
        serviceRow.action = "start unbound";
        serviceRow.addToList(services);
        emit servicesBodyListChanged();

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
    }

signals:
    void addSearchRow(SearchResultRow *row, bool isCask);
    void parseRefreshServicesSignal(QString strResult);

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

    void asyncRefreshServices(const QJSValue &callback)
    {
        QVector<GridCell *> *list;
        list = &servicesBodyList();

        qDeleteAll(*list);
        list->clear();

        setRefreshStatusServicesText("Refresh services");
        setRefreshStatusServicesVisible(true);
        setRefreshServicesRunning(true);

        makeAsync<bool>(callback, [=]() {
            ShellCmd sc;
            ProcessStatus s = sc.cmdListServices();

            if (s.isSuccess && !s.stdOut.isEmpty()) {
                qDebug() << s.stdOut;
                emit parseRefreshServicesSignal(s.stdOut);
            } else {
                if (s.stdErr.isEmpty()) {
                    s.stdErr = "Err" + QString::number(s.exitCode);
                }
            }
            if (!s.stdErr.isEmpty()) {
                setRefreshStatusServicesText(s.stdErr);
                setRefreshStatusServicesVisible(true);
            } else {
                setRefreshStatusServicesVisible(false);
            }
            setRefreshServicesRunning(false);
            emit servicesBodyListChanged();
            //emit of
            //sc.parseCmdListServices(s;
            return true;
        });
    }
    void asyncRefreshFormula(const QJSValue &callback)
    {
        makeAsync<bool>(callback, [=]() {
            return true;
        });
    }

    void asyncRefreshCask(const QJSValue &callback)
    {
        makeAsync<bool>(callback, [=]() { return true; });
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

private slots:
    void parseRefreshServices(QString strResult)
    {
        ShellCmd sc;
        sc.parseServicesList(strResult, &servicesBodyList());
    }

private:
    QSettings settings{"shemeshg", "Cakebrewjs2"};

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
};
