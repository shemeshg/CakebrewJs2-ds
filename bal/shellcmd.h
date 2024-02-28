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

    void externalTerminalCmd()
    {
        QString cmdToRun = "ls -l /Volumes/FAST/develop/cakebrewJs/src";
        QString s = R"(trap "rm %1" EXIT;%2)";

        QTemporaryFile file;
        file.setAutoRemove(false);
        if (file.open()) {
            s = s.arg(file.fileName(), cmdToRun);
            qDebug() << s;
            file.write(s.toUtf8());
            file.flush();

            exec("chmod", {"+x", file.fileName()});
            exec("open", {"-a", "Terminal", file.fileName()});

            qDebug() << "Finished";
        }
    }

    ProcessStatus exec(const QString program, const QStringList arguments)
    {
        QProcess pingProcess;
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
