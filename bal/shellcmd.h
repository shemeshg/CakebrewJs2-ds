#pragma once
#include <QDebug>
#include <QEventLoop>
#include <QFileSystemWatcher>
#include <QProcess>
#include <QString>
#include <QTemporaryFile>
#include "GridCell.h"
#include "ServiceRow.h"
#include "json/single_include/nlohmann/json.hpp"
#include "searchresultrow.h"

using json = nlohmann::json;

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
    void parseServicesList(QString &strResult, QVector<GridCell *> *list)
    {
        json data = json::parse(strResult.toStdString());
        for (auto &element : data) {
            std::string name = element["name"].template get<std::string>();
            std::string status = (element["status"]).template get<std::string>();
            std::string file = element["file"].template get<std::string>();
            std::string user;

            std::string action = "start";
            if (!element["user"].is_null()) {
                user = element["user"].template get<std::string>();
                action = "stop";
            }
            ServiceRow serviceRow{};
            serviceRow.name = QString::fromStdString(name);
            serviceRow.status = QString::fromStdString(status);
            serviceRow.user = QString::fromStdString(user);
            serviceRow.plist = QString::fromStdString(file);
            serviceRow.action = QString::fromStdString(action);
            serviceRow.addToList(list);
        }
    }

    QVector<SearchResultRow *> parseCmdSearch(QString searchResult, bool isCask)
    {
        QVector<SearchResultRow *> v;

        json data = json::parse(searchResult.toStdString());
        if (isCask) {
            data = data["casks"];
        } else {
            data = data["formulae"];
        }
        for (auto &element : data) {
            try {
                if (isCask) {
                    std::string token = element["token"].template get<std::string>();
                    std::string name = (element["name"][0]).template get<std::string>();
                    std::string version = element["version"].template get<std::string>();
                    std::string homepage = element["homepage"].template get<std::string>();

                    std::string desc;
                    if (!element["desc"].is_null()) {
                        desc = element["desc"].template get<std::string>();
                    }

                    bool installed = !element["installed"].is_null();

                    SearchResultRow *r = new SearchResultRow();
                    r->setToken(QString::fromStdString(token));
                    r->setName(QString::fromStdString(name));
                    r->setVersion(QString::fromStdString(version));
                    r->setHomepage(QString::fromStdString(homepage));
                    r->setDesc(QString::fromStdString(desc));
                    r->setInstalled(installed);

                    v.push_back(r);
                } else {
                    std::string token = element["name"].template get<std::string>();
                    std::string name = element["full_name"].template get<std::string>();
                    std::string version = (element["versions"]["stable"]).template get<std::string>();
                    std::string homepage = element["homepage"].template get<std::string>();
                    std::string desc = element["desc"].template get<std::string>();
                    bool installed = element["installed"].size() != 0;

                    SearchResultRow *r = new SearchResultRow();
                    r->setToken(QString::fromStdString(token));
                    r->setName(QString::fromStdString(name));
                    r->setVersion(QString::fromStdString(version));
                    r->setHomepage(QString::fromStdString(homepage));
                    r->setDesc(QString::fromStdString(desc));
                    r->setInstalled(installed);

                    v.push_back(r);
                }
            } catch (std::exception e) {
                std::string token = element["token"].template get<std::string>();
                qDebug() << e.what() << token;
            }
        }
        return v;
    }

    ProcessStatus cmdSearch(QString textSearch, bool isCask)
    {
        QString caskFormulaStr = isCask ? "--cask" : "--formula";

        QTemporaryFile fTmp;

        QString cmd = R"(#!/bin/sh
/usr/local/bin/brew search %1 $1|head -50|xargs /usr/local/bin/brew info %1 --json=v2)";
        cmd = cmd.arg(caskFormulaStr);
        if (fTmp.open()) {
            fTmp.write(cmd.toUtf8());
            fTmp.flush();
        }
        exec("chmod", {"+x", fTmp.fileName()});
        return exec(fTmp.fileName(), {textSearch});

        /*
        QFile dbg{"//Volumes/RAM_Disk_4G/k"};
        dbg.open(QIODevice::WriteOnly | QIODevice::Text);
        dbg.write(casks.stdOut.toUtf8());
        qDebug() << casks.stdOut;        
        */
    }

    ProcessStatus cmdListServices()
    {
        QString cmd = "/usr/local/bin/brew";
        return exec(cmd, {"services", "--json"});
    }

    void externalTerminalCmd(QString cmdToRun)
    {
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
        QFileSystemWatcher watcher;
        watcher.addPath(file.fileName());
        QEventLoop loop;
        QObject::connect(&watcher, &QFileSystemWatcher::fileChanged, &loop, &QEventLoop::quit);
        loop.exec();
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

        if (pingProcess.exitStatus() != QProcess::NormalExit || pingProcess.exitCode() != 0) {
            ps.isSuccess = false;
        }

        ps.exitCode = pingProcess.exitCode();
        ps.stdErr = stdErr;
        ps.stdOut = stdOut;

        return ps;
    }
};
