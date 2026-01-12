#pragma once
#include <QDebug>
#include <QEventLoop>
#include <QFileSystemWatcher>
#include <QProcess>
#include <QString>
#include <QTemporaryFile>

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

    ProcessStatus cmdSearch(QString textSearch, bool isCask);

    ProcessStatus cmdBrewUpdate(bool isUpdateForce);

    ProcessStatus cmdListCaskAndFormula();

    ProcessStatus cmdListServices();

    ProcessStatus cmdGetInfo(QString token, bool isCask);

    ProcessStatus cmdGetBrewVersion();

    ProcessStatus cmdPin(QString token);

    ProcessStatus cmdUnpin(QString token);

    ProcessStatus cmdGetInfoText(QString token, bool isCask);

    ProcessStatus getBrewUses(QString token);

    ProcessStatus cmdGetcCellarSize(QString token);

    ProcessStatus cmdGetCaskroomSize(QString token);

    void externalTerminalCmd(QString cmdToRun);

    ProcessStatus exec(const QString program, const QStringList arguments, bool noGithubApi = true);

private:
    QString brewLocation, terminalApp;
    std::string randomTempScriptName();
};
