#pragma once
#include <QDebug>
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
    ShellCmd();

    void getSearch(QString textSearch)
    {
        QTemporaryFile fCasks, fFormulas;

        QString cmdCask = R"(#!/bin/sh
/usr/local/bin/brew search --cask $1|head -50|xargs /usr/local/bin/brew info --cask --json=v2)";
        if (fCasks.open()) {
            fCasks.write(cmdCask.toUtf8());
            fCasks.flush();
        }
        exec("chmod", {"+x", fCasks.fileName()});
        auto casks = exec(fCasks.fileName(), {textSearch});

        QString cmdFormulas = R"(#!/bin/sh
/usr/local/bin/brew search --formula $1|head -50|xargs /usr/local/bin/brew info --formula --json=v2)";
        if (fFormulas.open()) {
            fFormulas.write(cmdFormulas.toUtf8());
            fFormulas.flush();
        }
        exec("chmod", {"+x", fFormulas.fileName()});
        auto formulas = exec(fFormulas.fileName(), {textSearch});

        QFile dbg{"//Volumes/RAM_Disk_4G/k"};
        dbg.open(QIODevice::WriteOnly | QIODevice::Text);
        dbg.write(casks.stdOut.toUtf8());

        qDebug() << casks.stdOut;
    }

    void externalTerminalCmd()
    {
        QString cmdToRun = "ls -l /Volumes/FAST/develop/cakebrewJs/src";
        QString s = R"(trap "rm %1" EXIT;%2)";

        QTemporaryFile file;
        file.setAutoRemove(false);
        if (file.open()) {
            s = s.arg(file.fileName(), cmdToRun);
            file.write(s.toUtf8());
            file.flush();

            exec("chmod", {"+x", file.fileName()});
            exec("open", {"-a", "Terminal", file.fileName()});
        }
    }

    ProcessStatus exec(const QString program, const QStringList arguments)
    {
        QProcess pingProcess;
        QProcessEnvironment env = QProcessEnvironment::systemEnvironment();
        env.insert("HOMEBREW_NO_GITHUB_API", "1");
        pingProcess.setProcessEnvironment(env);

        pingProcess.start(program, {arguments});
        pingProcess.waitForFinished(); // sets current thread to sleep and waits for pingProcess end

        QString stdOut(pingProcess.readAllStandardOutput()),
            stdErr{pingProcess.readAllStandardError()};
        pingProcess.close();

        ProcessStatus ps;
        ps.isSuccess = true;

        if (pingProcess.exitStatus() != QProcess::NormalExit && pingProcess.exitCode() != 0) {
            ps.isSuccess = false;
        }

        ps.exitCode = pingProcess.exitCode();
        ps.stdErr = stdErr;
        ps.stdOut = stdOut;

        return ps;
    }
};
