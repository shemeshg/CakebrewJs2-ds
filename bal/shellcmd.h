#pragma once
#include <QDebug>
#include <QEventLoop>
#include <QFileSystemWatcher>
#include <QProcess>
#include <QString>
#include <QTemporaryFile>
#include "CaskRow.h"
#include "FormulaRow.h"
#include "ServiceRow.h"
#include "searchresultrow.h"

struct ProcessStatus
{
    bool isSuccess;
    int exitCode;
    QString stdOut;
    QString stdErr;
};

class ShellCmd
{
public:
    ShellCmd(QString brewLocation, QString terminalApp);
    QVector<ServiceRow> parseServicesList(QString &strResult);

    QVector<FormulaRow> parseFormulaList(QString &strResult);

    QVector<CaskRow> parseCaskList(QString &strResult);

    QVector<SearchResultRow *> parseCmdSearch(QString searchResult, bool isCask);

    ProcessStatus cmdSearch(QString textSearch, bool isCask);

    ProcessStatus cmdBrewUpdate();

    ProcessStatus cmdListCaskAndFormula();

    ProcessStatus cmdListServices();

    ProcessStatus cmdGetInfo(QString token, bool isCask);

    ProcessStatus cmdPin(QString token);

    ProcessStatus cmdUnpin(QString token);

    ProcessStatus cmdGetInfoText(QString token, bool isCask);

    ProcessStatus cmdGetcCellarSize(QString token);

    ProcessStatus cmdGetCaskroomSize(QString token);

    void externalTerminalCmd(QString cmdToRun);

    ProcessStatus exec(const QString program, const QStringList arguments, bool noGithubApi = true);

private:
    QString brewLocation, terminalApp;
};
