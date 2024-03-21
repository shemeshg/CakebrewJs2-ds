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
#include "json/single_include/nlohmann/json.hpp"
#include "searchresultrow.h"
#include <iostream>
#include <map>

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
    QVector<ServiceRow> parseServicesList(QString &strResult)
    {
        QVector<ServiceRow> serviceRows;
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
            serviceRows.emplaceBack(serviceRow);
        }
        return serviceRows;
    }

    QVector<FormulaRow> parseFormulaList(QString &strResult)
    {
        QVector<FormulaRow> rows;
        json data = json::parse(strResult.toStdString());
        std::map<std::string, std::vector<std::string>> usedIn;

        for (auto &element : data["formulae"]) {
            usedIn[element["name"].template get<std::string>()] = {};
        }
        for (auto &element : data["formulae"]) {
            std::string name = element["name"].template get<std::string>();
            std::string fullName = element["full_name"].template get<std::string>();
            std::string desc = (element["desc"]).template get<std::string>();
            std::string tap = element["tap"].template get<std::string>();
            std::string homepage = element["homepage"].template get<std::string>();
            std::string license;
            if (!element["license"].is_null()) {
                license = element["license"].template get<std::string>();
            }
            std::string ruby_source_path = element["ruby_source_path"].template get<std::string>();
            std::string updatedVersion = (element["versions"]["stable"]).template get<std::string>();
            bool isInstalled = element["installed"].size() != 0;
            bool isOutdated = false;
            bool isPinned = false;
            bool installedOnRequest = false;
            std::string installedVersion;
            if (isInstalled) {
                installedVersion = (element["installed"][0]["version"]).template get<std::string>();
                isOutdated = element["outdated"].template get<bool>();
                isPinned = element["pinned"].template get<bool>();
                installedOnRequest = (element["installed"][0]["installed_on_request"])
                                         .template get<bool>();
            }

            FormulaRow row{};
            row.token = QString::fromStdString(name);
            row.fullName = QString::fromStdString(fullName);
            row.desc = QString::fromStdString(desc);
            row.tap = QString::fromStdString(tap);
            row.version = QString::fromStdString(installedVersion);
            row.outdated = QString::fromStdString(updatedVersion);
            row.ruby_source_path = QString::fromStdString(ruby_source_path);
            row.homepage = QString::fromStdString(homepage);
            row.license = QString::fromStdString(license);
            row.isOutdated = isOutdated;
            row.isPinned = isPinned;
            row.installedOnRequest = installedOnRequest;
            row.isInstalled = isInstalled;

            for (auto &dep : element["dependencies"]) {
                std::string d = dep.template get<std::string>();
                row.dependencies.push_back(QString::fromStdString(d));
                bool found = (usedIn.find(d) != usedIn.end());
                if (found) {
                    usedIn[d].push_back(row.token.toStdString());
                }                
            }

            for (auto &dep : element["build_dependencies"]) {
                std::string d = dep.template get<std::string>();
                row.buildDependencies.push_back(QString::fromStdString(d));
            }

            rows.emplaceBack(row);
        }

        for (auto &row : rows) {
            for (const auto &str : usedIn[row.token.toStdString()]) {
                row.usedIn << QString::fromStdString(str);
            }
        }
        return rows;
    }

    QVector<CaskRow> parseCaskList(QString &strResult)
    {
        QVector<CaskRow> rows;
        json data = json::parse(strResult.toStdString());
        for (auto &element : data["casks"]) {
            std::string token = element["token"].template get<std::string>();
            std::string name = (element["name"][0]).template get<std::string>();
            std::string desc = (element["desc"]).template get<std::string>();
            std::string tap = element["tap"].template get<std::string>();
            std::string homepage = element["homepage"].template get<std::string>();
            std::string ruby_source_path = element["ruby_source_path"].template get<std::string>();
            std::string version;
            bool isInstalled = false;
            if (!element["installed"].is_null()) {
                version = element["installed"].template get<std::string>();
                isInstalled = true;
            }
            std::string outdated;
            bool isOutdated = element["outdated"].template get<bool>();            
            outdated = element["version"].template get<std::string>();

            std::string artifacts;
            for (auto &art : element["artifacts"].items()) {
                if (art.value().contains("app")) {
                    for (auto &app : art.value()["app"]) {
                        if (app.is_string()) {
                            artifacts = artifacts + app.template get<std::string>() + " (app)\n";
                        }
                    }
                }
                if (art.value().contains("binary")) {
                    for (auto &app : art.value()["binary"]) {
                        if (app.is_string()) {
                            artifacts = artifacts + app.template get<std::string>() + " (bin)\n";
                        }
                    }
                }
            }

            CaskRow cr{};
            cr.token = QString::fromStdString(token);
            cr.desc = QString::fromStdString(desc);
            cr.tap = QString::fromStdString(tap);
            cr.version = QString::fromStdString(version);
            cr.outdated = QString::fromStdString(outdated);
            cr.isOutdated = isOutdated;
            cr.isInstalled = isInstalled;
            cr.name = QString::fromStdString(name);
            cr.homepage = QString::fromStdString(homepage);
            cr.ruby_source_path = QString::fromStdString(ruby_source_path);
            cr.artifacts = QString::fromStdString(artifacts);

            rows.emplaceBack(cr);
        }
        return rows;
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
    }

    ProcessStatus cmdBrewUpdate()
    {
        QString cmd = "/usr/local/bin/brew";
        return exec(cmd, {"update"});
    }

    ProcessStatus cmdListCaskAndFormula()
    {
        QString cmd = "/usr/local/bin/brew";
        return exec(cmd, {"info", "--installed", "--json=v2"});
    }

    ProcessStatus cmdListServices()
    {
        QString cmd = "/usr/local/bin/brew";
        return exec(cmd, {"services", "--json"});
    }

    ProcessStatus cmdGetInfo(QString token, bool isCask)
    {
        QString cmd = "/usr/local/bin/brew";
        QString type = isCask ? "--cask" : "--formula";

        return exec(cmd, {"info", type, "--json=v2", token});
    }

    ProcessStatus cmdPin(QString token)
    {
        QString cmd = "/usr/local/bin/brew";

        return exec(cmd,
                    {
                        "pin",
                        token,
                    });
    }

    ProcessStatus cmdUnpin(QString token)
    {
        QString cmd = "/usr/local/bin/brew";

        return exec(cmd,
                    {
                        "unpin",
                        token,
                    });
    }

    ProcessStatus cmdGetInfoText(QString token, bool isCask)
    {
        QString cmd = "/usr/local/bin/brew";
        QString type = isCask ? "--cask" : "--formula";

        return exec(cmd, {"info", type, token}, false);
    }

    ProcessStatus cmdGetcCellarSize(QString token)
    {
        QString s = R"(#!/bin/zsh
find `/usr/local/bin/brew --cellar`/$1 -mindepth 2 -maxdepth 2  -not -path '*/.*'| xargs  du -shHc|tail -n 1)";

        QTemporaryFile file;
        file.open();
        file.write(s.toUtf8());
        file.flush();

        exec("chmod", {"+x", file.fileName()});
        return exec(file.fileName(), {token});
    }

    ProcessStatus cmdGetCaskroomSize(QString token)
    {
        QString s = R"(#!/bin/zsh
find `/usr/local/bin/brew --caskroom`/$1 -mindepth 2 -maxdepth 2  -not -path '*/.*'| xargs  du -shHc|tail -n 1)";

        QTemporaryFile file;
        file.open();
        file.write(s.toUtf8());
        file.flush();

        exec("chmod", {"+x", file.fileName()});
        return exec(file.fileName(), {token});
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

    ProcessStatus exec(const QString program, const QStringList arguments, bool noGithubApi = true)
    {
        QProcess pingProcess;
        QProcessEnvironment env = QProcessEnvironment::systemEnvironment();
        if (noGithubApi) {
            env.insert("HOMEBREW_NO_GITHUB_API", "1");
        }
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
