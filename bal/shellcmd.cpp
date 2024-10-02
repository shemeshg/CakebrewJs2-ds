#include "shellcmd.h"

ShellCmd::ShellCmd(QString brewLocation, QString terminalApp)
    : brewLocation{brewLocation}
    , terminalApp{terminalApp}
{}

ProcessStatus ShellCmd::cmdSearch(QString textSearch, bool isCask)
{
    QString caskFormulaStr = isCask ? "--cask" : "--formula";

    QTemporaryFile fTmp;

    QString cmd = R"(#!/bin/sh
%1 search %2 $1|head -50|xargs %1 info %2 --json=v2)";
    cmd = cmd.arg(brewLocation, caskFormulaStr);
    if (fTmp.open()) {
        fTmp.write(cmd.toUtf8());
        fTmp.flush();
    }
    exec("chmod", {"+x", fTmp.fileName()});
    return exec(fTmp.fileName(), {textSearch});
}

ProcessStatus ShellCmd::cmdBrewUpdate(bool isUpdateForce)
{
    QString cmd = brewLocation;
    if (isUpdateForce) {
        return exec(cmd, {"update"}, "-f");
    } else {
        return exec(cmd, {"update"});
    }
}

ProcessStatus ShellCmd::cmdListCaskAndFormula()
{
    QString cmd = brewLocation;
    return exec(cmd, {"info", "--installed", "--json=v2"});
}

ProcessStatus ShellCmd::cmdListServices()
{
    QString cmd = brewLocation;
    return exec(cmd, {"services", "--json"});
}

ProcessStatus ShellCmd::cmdGetInfo(QString token, bool isCask)
{
    QString cmd = brewLocation;
    QString type = isCask ? "--cask" : "--formula";

    return exec(cmd, {"info", type, "--json=v2", token});
}

ProcessStatus ShellCmd::cmdPin(QString token)
{
    QString cmd = brewLocation;

    return exec(cmd,
                {
                    "pin",
                    token,
                });
}

ProcessStatus ShellCmd::cmdUnpin(QString token)
{
    QString cmd = brewLocation;

    return exec(cmd,
                {
                    "unpin",
                    token,
                });
}

ProcessStatus ShellCmd::cmdGetInfoText(QString token, bool isCask)
{
    QString cmd = brewLocation;
    QString type = isCask ? "--cask" : "--formula";

    return exec(cmd, {"info", type, token}, false);
}

ProcessStatus ShellCmd::getBrewUses(QString token)
{
    QString cmd = brewLocation;

    return exec(cmd, {"uses", "--installed", token}, false);
}

ProcessStatus ShellCmd::cmdGetcCellarSize(QString token)
{
    QString s = R"(#!/bin/zsh
find `%1 --cellar`/$1 -mindepth 2 -maxdepth 2  -not -path '*/.*'| xargs  du -shHc|tail -n 1)";

    s = s.arg(brewLocation);
    QTemporaryFile file;
    file.open();
    file.write(s.toUtf8());
    file.flush();

    exec("chmod", {"+x", file.fileName()});
    return exec(file.fileName(), {token});
}

ProcessStatus ShellCmd::cmdGetCaskroomSize(QString token)
{
    QString s = R"(#!/bin/zsh
find `%1 --caskroom`/$1 -mindepth 2 -maxdepth 4  -not -path '*/.*'|  tr \\n \\0 |  xargs -0 du -shHc|tail -n 1)";
    s = s.arg(brewLocation);

    QTemporaryFile file;
    file.open();
    file.write(s.toUtf8());
    file.flush();

    exec("chmod", {"+x", file.fileName()});
    return exec(file.fileName(), {token});
}

void ShellCmd::externalTerminalCmd(QString cmdToRun)
{
    QString s = R"(trap "rm %1" EXIT;%2)";

    QTemporaryFile file;
    file.setAutoRemove(false);
    if (file.open()) {
        s = s.arg(file.fileName(), cmdToRun);
        file.write(s.toUtf8());
        file.flush();

        exec("chmod", {"+x", file.fileName()});
        exec("open", {"-a", terminalApp, file.fileName()});
    }
    QFileSystemWatcher watcher;
    watcher.addPath(file.fileName());
    QEventLoop loop;
    QObject::connect(&watcher, &QFileSystemWatcher::fileChanged, &loop, &QEventLoop::quit);
    loop.exec();
}

ProcessStatus ShellCmd::exec(const QString program, const QStringList arguments, bool noGithubApi)
{
    QProcess pingProcess;
    QProcessEnvironment env = QProcessEnvironment::systemEnvironment();
    if (noGithubApi) {
        env.insert("HOMEBREW_NO_GITHUB_API", "1");
    }
    pingProcess.setProcessEnvironment(env);

    pingProcess.start(program, {arguments});
    pingProcess.waitForFinished(-1); // sets current thread to sleep and waits for pingProcess end

    QString stdOut(pingProcess.readAllStandardOutput()), stdErr{pingProcess.readAllStandardError()};
    pingProcess.close();

    ProcessStatus ps;
    ps.isSuccess = true;

    if (pingProcess.exitStatus() != QProcess::NormalExit || pingProcess.exitCode() != 0) {
        ps.isSuccess = false;
    }

    ps.exitCode = pingProcess.exitCode();
    ps.stdErr = stdErr;
    ps.stdOut = stdOut;

    return ps;
}
