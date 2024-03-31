#include "BrewData.h"
#include "ParseCmd.h"
BrewData::BrewData(QObject *parent)
    : BrewDataPrivate{parent}
{
    loadBrewLocation();
    loadNormalFontPointSize();
    loadTerminalApp();
    loadIsExtendedCask();
    loadIsExtendedFormula();
    loadIsExtendedService();
    loadIsShowBrewInfoText();

    /*
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
        
        */

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

void BrewData::asyncSearch(const QJSValue &callback, QString textSearch, bool isCask)
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
        ShellCmd sc = getShellCmd();
        ProcessStatus s = sc.cmdSearch(textSearch, isCask);
        if (s.isSuccess && !s.stdOut.isEmpty()) {
            ParseCmd pc;
            QVector<SearchResultRow *> parseCmdSearch = pc.parseCmdSearch(s.stdOut, isCask);

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

void BrewData::asyncBrewActionSelected(QStringList casks,
                                       QStringList formulas,
                                       QString action,
                                       const QJSValue &callback)
{
    refreshCaskAndFormulaBeforeCallback();
    makeAsync<bool>(callback, [=]() {
        ShellCmd sc = getShellCmd();
        QString cmd;
        QString cmdTemplate = "%1 %2 %3 %4";
        if (casks.size() > 0) {
            QStringList escCasks;
            for (auto &i : casks) {
                escCasks.push_back("'" + i + "'");
            }
            cmd = cmdTemplate.arg("/usr/local/bin/brew", action, "--cask", escCasks.join(" "))
                  + ";";
        }
        if (formulas.size() > 0) {
            QStringList escFormulas;
            for (auto &i : formulas) {
                escFormulas.push_back("'" + i + "'");
            }
            cmd = cmd
                  + cmdTemplate.arg("/usr/local/bin/brew",
                                    action,
                                    "--formula",
                                    escFormulas.join(" "))
                  + ";";
        }
        sc.externalTerminalCmd(cmd);
        refreshCaskAndFormulaAfterCallback(false);
        return true;
    });
}

void BrewData::asyncBrewUpgradeSelected(QStringList casks,
                                        QStringList formulas,
                                        const QJSValue &callback)
{
    asyncBrewActionSelected(casks, formulas, "upgrade", callback);
}

void BrewData::asyncBrewUpgradeAll(const QJSValue &callback)
{
    refreshCaskAndFormulaBeforeCallback();
    makeAsync<bool>(callback, [=]() {
        ShellCmd sc = getShellCmd();
        QString cmd = "%1 '%2'";
        cmd = cmd.arg("/usr/local/bin/brew", "upgrade");
        sc.externalTerminalCmd(cmd);
        refreshCaskAndFormulaAfterCallback(false);
        return true;
    });
}

void BrewData::asyncBrewDoctor(const QJSValue &callback)
{
    makeAsync<bool>(callback, [=]() {
        ShellCmd sc = getShellCmd();
        QString cmd = "%1 '%2'";
        cmd = cmd.arg("/usr/local/bin/brew", "doctor");
        sc.externalTerminalCmd(cmd);
        return true;
    });
}

void BrewData::asyncServiceAction(const QJSValue &callback, QString name, QString action)
{
    refreshServicesBeforeCallback();
    makeAsync<bool>(callback, [=]() {
        ShellCmd sc = getShellCmd();
        QString cmd = "%1 services '%2' '%3'";
        cmd = cmd.arg("/usr/local/bin/brew", action, name);
        sc.externalTerminalCmd(cmd);
        refreshServicesAfterCallback();
        return true;
    });
}

void BrewData::asyncRefreshServices(const QJSValue &callback, bool loadFromCash)
{
    refreshServicesBeforeCallback();

    if (loadFromCash) {
        QString cash = cashFileRead("cmdListServices.txt");
        if (!cash.isEmpty()) {
            emit parseRefreshServicesSignal(cash);
        }
    }

    makeAsync<bool>(callback, [=]() {
        refreshServicesAfterCallback();
        return true;
    });
}

void BrewData::asyncPin(QString token, const QJSValue &callback)
{
    makeAsync<bool>(callback, [=]() {
        ShellCmd sc = getShellCmd();
        ProcessStatus s = sc.cmdPin(token);
        return true;
    });
}

void BrewData::asyncUnpin(QString token, const QJSValue &callback)
{
    makeAsync<bool>(callback, [=]() {
        ShellCmd sc = getShellCmd();
        ProcessStatus s = sc.cmdUnpin(token);
        return true;
    });
}

void BrewData::asyncRefreshCaskAndFormula(bool doBrewUpdate,
                                          const QJSValue &callback,
                                          bool loadFromCash)
{
    refreshCaskAndFormulaBeforeCallback();

    if (loadFromCash) {
        QString cash = cashFileRead("cmdListCaskAndFormula.txt");
        if (!cash.isEmpty()) {
            emit parseRefreshCaskAndFormulaSignal(cash);
        }
    }

    makeAsync<bool>(callback, [=]() {
        refreshCaskAndFormulaAfterCallback(doBrewUpdate);
        return true;
    });
}

void BrewData::saveTerminalApp(const QString s)
{
    settings.setValue("terminalApp", s);
    loadTerminalApp();
}

void BrewData::saveNormalFontPointSize(const QString s)
{
    settings.setValue("normalFontPointSize", s);
    loadNormalFontPointSize();
}

void BrewData::saveBrewLocation(const QString s)
{
    settings.setValue("brewLocation", s);
    loadBrewLocation();
}

void BrewData::saveIsExtendedCask(const bool s)
{
    settings.setValue("isExtendedCask", s);
    loadIsExtendedCask();
}

void BrewData::saveIsExtendedFormula(const bool s)
{
    settings.setValue("isExtendedFormula", s);
    loadIsExtendedFormula();
}

void BrewData::saveIsExtendedService(const bool s)
{
    settings.setValue("isExtendedService", s);
    loadIsExtendedService();
}

void BrewData::saveIsShowBrewInfoText(const bool s)
{
    settings.setValue("isShowBrewInfoText", s);
    loadIsShowBrewInfoText();
}

void BrewData::asyncFormulaSort(const QJSValue &callback)
{
    makeAsync<bool>(callback, [=]() {
        formulaSort();
        return true;
    });
}

void BrewData::formulaSort()
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

void BrewData::asyncCaskSort(const QJSValue &callback)
{
    makeAsync<bool>(callback, [=]() {
        caskSort();
        return true;
    });
}

void BrewData::caskSort()
{
    std::sort(caskRows.begin(), caskRows.end(), [=](CaskRow &a, CaskRow &b) {
        QString aOutdatedText = a.isOutdated ? a.outdated : "";
        QString bOutdatedText = b.isOutdated ? b.outdated : "";
        if (caskSortedColIdx() == 4 && caskSortedColOrder() == 1) {
            return aOutdatedText + a.token > bOutdatedText + b.token;
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

        return aOutdatedText + a.token < bOutdatedText + b.token;
    });

    caskTableBodyList().clear();
    CaskRow fr{};
    fr.addListHeader(caskTableBodyList());

    for (CaskRow &r : caskRows) {
        r.addToList(caskTableBodyList());
    }

    emit caskTableBodyListChanged();
}

void BrewData::asyncGetInfoText(QString token, bool isCask, const QJSValue &callback)
{
    makeAsync<QString>(callback, [=]() { return getInfoText(token, isCask); });
}

QString BrewData::getInfoText(const QString token, bool isCask)
{
    ShellCmd sc = getShellCmd();
    ProcessStatus s = sc.cmdGetInfoText(token, isCask);
    if (s.isSuccess && !s.stdOut.isEmpty()) {
        return s.stdOut;
    } else {
        if (s.stdErr.isEmpty()) {
            s.stdErr = "Err" + QString::number(s.exitCode);
        }
        return s.stdErr;
    }
}

void BrewData::asyncGetInfo(QString token, bool isCask, const QJSValue &callback)
{        
    makeAsync<QVariant>(callback, [=]() { return getInfo(token, isCask); });
}

QVariant BrewData::getInfo(const QString token, bool isCask)
{
    setInfoToken(token);
    QMap<QString, QVariant> row;

    if (isCask) {
        auto it = std::find_if(caskRows.begin(), caskRows.end(), [=](auto &row) {
            return row.token == token;
        });
        if (it != caskRows.end()) {
            setRowFromCaskRow(row, *it);
        } else {
            ShellCmd sc = getShellCmd();
            ProcessStatus s = sc.cmdGetInfo(token, isCask);
            if (s.isSuccess && !s.stdOut.isEmpty()) {
                ParseCmd pc;
                CaskRow caskRow = pc.parseCaskList(s.stdOut).at(0);
                setRowFromCaskRow(row, caskRow);
            } else {
                if (s.stdErr.isEmpty()) {
                    s.stdErr = "Err" + QString::number(s.exitCode);
                }
                row["infoStatus"] = isCask ? (int) InfoStatus::CaskNotFound
                                           : (int) InfoStatus::FormulaNotFound;
            }
            row["err"] = s.stdErr;
        }
    } else {
        auto it = std::find_if(formulaRows.begin(), formulaRows.end(), [=](auto &row) {
            return row.token == token;
        });
        if (it != formulaRows.end()) {
            setRowFromFormulaRow(row, *it);
        } else {
            ShellCmd sc = getShellCmd();
            ProcessStatus s = sc.cmdGetInfo(token, isCask);
            if (s.isSuccess && !s.stdOut.isEmpty()) {
                ParseCmd pc;
                FormulaRow formulaRow = pc.parseFormulaList(s.stdOut).at(0);
                setRowFromFormulaRow(row, formulaRow);
            } else {
                if (s.stdErr.isEmpty()) {
                    s.stdErr = "Err" + QString::number(s.exitCode);
                }
                row["infoStatus"] = isCask ? (int) InfoStatus::CaskNotFound
                                           : (int) InfoStatus::FormulaNotFound;
            }
            row["err"] = s.stdErr;
        }
    }

    return row;
}

void BrewData::asyncServiceSort(const QJSValue &callback)
{
    makeAsync<bool>(callback, [=]() {
        serviceSort();
        return true;
    });
}

void BrewData::serviceSort()
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

void BrewData::parseRefreshServices(QString strResult)
{
    ShellCmd sc = getShellCmd();
    ParseCmd pc;

    try {
        serviceRows = pc.parseServicesList(strResult);
    } catch (const std::exception &e) {
        qDebug() << "Exception caught: " << e.what();
    } catch (...) {
        qDebug() << "Exception caught: ";
    }
    serviceSort();
}

void BrewData::parseRefreshCaskAndFormula(QString strResult)
{
    ShellCmd sc = getShellCmd();
    ParseCmd pc;

    try {
        caskRows = pc.parseCaskList(strResult);
        formulaRows = pc.parseFormulaList(strResult);
    } catch (const std::exception &e) {
        qDebug() << "Exception caught: " << e.what();
    } catch (...) {
        qDebug() << "Exception caught: ";
    }

    caskSort();
    formulaSort();
}

const QString BrewData::getFindExecutable(const QString &exec) const
{
    auto full_path = QStandardPaths::findExecutable(exec);
    if (full_path.isEmpty()) {
        full_path = QStandardPaths::findExecutable(exec, {"/usr/local/bin", "/opt/homebrew/bin"});
    }

    return full_path;
}

void BrewData::loadNormalFontPointSize()
{
    QString s = settings.value("normalFontPointSize", "").toString();
    setNormalFontPointSize(s);
}

void BrewData::loadTerminalApp()
{
    QString s = settings.value("terminalApp", "iTerm").toString();
    setTerminalApp(s);
}

void BrewData::loadBrewLocation()
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

void BrewData::loadIsExtendedCask()
{
    bool s = settings.value("isExtendedCask", true).toBool();
    setIsExtendedCask(s);
}

void BrewData::loadIsExtendedFormula()
{
    bool s = settings.value("isExtendedFormula", true).toBool();
    setIsExtendedFormula(s);
}

void BrewData::loadIsExtendedService()
{
    bool s = settings.value("isExtendedService", true).toBool();
    setIsExtendedService(s);
}

void BrewData::loadIsShowBrewInfoText()
{
    bool s = settings.value("isShowBrewInfoText", false).toBool();
    setIsShowBrewInfoText(s);
}

void BrewData::refreshCaskAndFormulaBeforeCallback()
{
    setRefreshStatusFormulaText("Refresh formula");
    setRefreshStatusFormulaVisible(true);
    setRefreshFormulaRunning(true);

    setRefreshStatusCaskText("Refresh cask");
    setRefreshStatusCaskVisible(true);
    setRefreshCaskRunning(true);
}

void BrewData::refreshCaskAndFormulaAfterCallback(bool doBrewUpdate)
{    
    ShellCmd sc = getShellCmd();
    ProcessStatus s;
    QString refreshErr;
    if (doBrewUpdate) {
        s = sc.cmdBrewUpdate();
        if (!s.isSuccess) {
            refreshErr = "refresh failed: " + s.stdErr;
        }
    }

    s = sc.cmdListCaskAndFormula();

    if (s.isSuccess && !s.stdOut.isEmpty()) {
        cashFileWrite("cmdListCaskAndFormula.txt", s.stdOut);
        emit parseRefreshCaskAndFormulaSignal(s.stdOut);
    } else {
        if (s.stdErr.isEmpty()) {
            s.stdErr = "Err" + QString::number(s.exitCode);
        }
    }

    s.stdErr = refreshErr + s.stdErr;
    if (!s.stdErr.isEmpty()) {
        //setRefreshStatusFormulaText(s.stdErr);
        setRefreshStatusFormulaText("");
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

void BrewData::refreshServicesBeforeCallback()
{
    setRefreshStatusServiceText("Refresh services");
    setRefreshStatusServiceVisible(true);
    setRefreshServiceRunning(true);
}

void BrewData::refreshServicesAfterCallback()
{
    ShellCmd sc = getShellCmd();
    ProcessStatus s = sc.cmdListServices();

    if (s.isSuccess && !s.stdOut.isEmpty()) {
        cashFileWrite("cmdListServices.txt", s.stdOut);
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

void BrewData::setRowFromCaskRow(QMap<QString, QVariant> &row, CaskRow &caskRow)
{
    row["infoStatus"] = (int) InfoStatus::CaskFound;
    row["token"] = caskRow.token;
    row["desc"] = caskRow.desc;
    row["tap"] = caskRow.tap;
    row["version"] = caskRow.version;
    row["outdated"] = caskRow.outdated;
    row["isOutdated"] = caskRow.isOutdated;
    row["isDeprecated"] = caskRow.isDeprecated;
    row["isInstalled"] = caskRow.isInstalled;
    row["name"] = caskRow.name;
    row["homepage"] = caskRow.homepage;
    row["ruby_source_path"] = caskRow.ruby_source_path;
    row["caskroomSize"] = "";
    if (caskRow.isInstalled) {
        ShellCmd sc = getShellCmd();
        row["caskroomSize"] = caskRow.getCaskroomSize(sc);
    }
    row["artifacts"] = caskRow.artifacts;
    row["err"] = "";
}

void BrewData::setRowFromFormulaRow(QMap<QString, QVariant> &row, FormulaRow &formulaRow)
{
    row["infoStatus"] = (int) InfoStatus::FormulaFound;
    row["token"] = formulaRow.token;
    row["fullName"] = formulaRow.fullName;
    row["desc"] = formulaRow.desc;
    row["tap"] = formulaRow.tap;
    row["version"] = formulaRow.version;
    row["outdated"] = formulaRow.outdated;
    row["leafText"] = formulaRow.leafText;
    row["isOutdated"] = formulaRow.isOutdated;
    row["installedOnRequest"] = formulaRow.installedOnRequest;
    row["isInstalled"] = formulaRow.isInstalled;
    row["isDeprecated"] = formulaRow.isDeprecated;
    row["usedIn"] = formulaRow.usedIn;
    row["homepage"] = formulaRow.homepage;
    row["ruby_source_path"] = formulaRow.ruby_source_path;
    row["license"] = formulaRow.license;
    row["dependencies"] = formulaRow.dependencies;
    row["buildDependencies"] = formulaRow.buildDependencies;
    row["isPinned"] = formulaRow.isPinned;

    row["cellarSize"] = "";
    if (formulaRow.isInstalled) {
        ShellCmd sc = getShellCmd();
        row["cellarSize"] = formulaRow.getCellarSize(sc);
    }
    row["err"] = "";
}

void BrewData::cashFileWrite(const QString &fileName, QString &fileContent)
{
    QString cacheFolderPath = QStandardPaths::writableLocation(QStandardPaths::CacheLocation);
    QString filePath = cacheFolderPath + QDir::separator() + fileName;
    QFile file(filePath);
    if (file.open(QIODevice::WriteOnly | QIODevice::Text)) {
        QTextStream out(&file);
        out << fileContent;
        file.close();
    }
}

QString BrewData::cashFileRead(const QString &fileName)
{
    QString cacheFolderPath = QStandardPaths::writableLocation(QStandardPaths::CacheLocation);
    QString filePath = cacheFolderPath + QDir::separator() + fileName;

    QString fileContent;
    // Check if the file exists
    if (QFile::exists(filePath)) {
        QFile file(filePath);
        if (file.open(QIODevice::ReadOnly | QIODevice::Text)) {
            QTextStream stream(&file);
            fileContent = stream.readAll();
            file.close();
        }
    }
    return fileContent;
}

ShellCmd BrewData::getShellCmd()
{
    return ShellCmd(brewLocation(), terminalApp());
}
