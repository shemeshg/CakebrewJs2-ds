#include "ParseCmd.h"
#include <nlohmann/json.hpp>

#define MAX_VER_LEN 20

using json = nlohmann::json;

QVector<ServiceRow> ParseCmd::parseServicesList(QString &strResult)
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

QVector<FormulaRow> ParseCmd::parseFormulaList(QString &strResult)
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
        bool isDeprecated = element["deprecated"].template get<bool>()
                            || element["disabled"].template get<bool>();
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
        row.version = QString::fromStdString(installedVersion).left(MAX_VER_LEN).simplified();
        row.outdated = QString::fromStdString(updatedVersion).left(MAX_VER_LEN).simplified();
        row.ruby_source_path = QString::fromStdString(ruby_source_path);
        row.homepage = QString::fromStdString(homepage);
        row.license = QString::fromStdString(license);
        row.isOutdated = isOutdated;
        row.isPinned = isPinned;
        row.installedOnRequest = installedOnRequest;
        row.isInstalled = isInstalled;
        row.isDeprecated = isDeprecated;
        row.caveats = getCaveats(element);

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

QVector<CaskRow> ParseCmd::parseCaskList(QString &strResult)
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
        bool isDeprecated = element["deprecated"].template get<bool>()
                            || element["disabled"].template get<bool>();
        outdated = element["version"].template get<std::string>();

        if (!element["auto_updates"].is_null()) {
            if (element["auto_updates"].template get<bool>()) {
                outdated = "🚗 " + outdated;
                version = "🚗 " + version;
            }
        }

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

        // start getCaveats

        // end getCaveats

        CaskRow cr{};
        cr.token = QString::fromStdString(token);

        cr.desc = QString::fromStdString(desc);

        cr.tap = QString::fromStdString(tap);

        cr.version = QString::fromStdString(version).left(MAX_VER_LEN).simplified();
        cr.outdated = QString::fromStdString(outdated).left(MAX_VER_LEN).simplified();
        cr.isOutdated = isOutdated;
        cr.isInstalled = isInstalled;
        cr.isDeprecated = isDeprecated;
        cr.name = QString::fromStdString(name);
        cr.homepage = QString::fromStdString(homepage);
        cr.ruby_source_path = QString::fromStdString(ruby_source_path);
        cr.artifacts = QString::fromStdString(artifacts);
        cr.caveats = getCaveats(element);

        rows.emplaceBack(cr);
    }
    return rows;
}

QVector<SearchResultRow *> ParseCmd::parseCmdSearch(QString searchResult, bool isCask)
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

QString ParseCmd::getCaveats(nlohmann::basic_json<> element)
{
    QStringList caveatsList;
    QString disable_date, disable_reason;
    QString deprecation_date, deprecation_reason;
    if (element["disabled"].template get<bool>()) {
        if (!element["disable_date"].is_null()) {
            disable_date = QString::fromStdString(
                element["disable_date"].template get<std::string>());
        }
        if (!element["disable_reason"].is_null()) {
            disable_reason = QString::fromStdString(
                element["disable_reason"].template get<std::string>());
        }
        caveatsList.push_back("disabled " + disable_date + " " + disable_reason);
    }
    if (element["deprecated"].template get<bool>()) {
        if (!element["deprecation_date"].is_null()) {
            deprecation_date = QString::fromStdString(
                element["deprecation_date"].template get<std::string>());
        }
        if (!element["deprecation_reason"].is_null()) {
            deprecation_reason = QString::fromStdString(
                element["deprecation_reason"].template get<std::string>());
        }
        caveatsList.push_back("deprecated " + deprecation_date + " " + deprecation_reason);
    }
    if (!element["caveats"].is_null()) {
        caveatsList.push_back(
            QString::fromStdString(element["caveats"].template get<std::string>()));
    }
    return caveatsList.join("\n");
}
