#pragma once
#include "BrewDataPrivate.h"

struct ProcessStatus
{
    bool isSuccess;
    int exitCode;
    QString stdOut;
    QString stdErr;
};

class BrewData : public BrewDataPrivate

{
    Q_OBJECT
    QML_ELEMENT
public:
    explicit BrewData(QObject *parent = nullptr)
        : BrewDataPrivate{parent}
    {
        loadBrewLocation();

        QVector<GridCell *> *cask = &caskBodyList();
        GridCell *gc;
        gc = new GridCell();
        gc->setCellType("linkBtn");
        gc->setCellText("anaconda");
        gc->setFillWidth(false);
        gc->setFilterString("anaconda");
        cask->push_back(gc);

        gc = new GridCell();
        gc->setCellType("text");
        gc->setCellText(
            "Distribution of the Python and R programming languages for scientific computing");
        gc->setFillWidth(true);
        gc->setFilterString("anaconda");
        cask->push_back(gc);

        gc = new GridCell();
        gc->setCellType("text");
        gc->setCellText("homebrew/tap");
        gc->setFillWidth(false);
        gc->setFilterString("anaconda");
        cask->push_back(gc);

        gc = new GridCell();
        gc->setCellType("text");
        gc->setCellText("1.3.5");
        gc->setFillWidth(false);
        gc->setFilterString("anaconda");
        cask->push_back(gc);

        gc = new GridCell();
        gc->setCellType("checkbox");
        gc->setCellText("1.3.6");
        gc->setFillWidth(false);
        gc->setFilterString("anaconda");
        gc->setOnToggled("anaconda");
        cask->push_back(gc);

        emit caskBodyListChanged();

        QVector<GridCell *> *formula = &formulaBodyList();

        gc = new GridCell();
        gc->setCellType("linkBtn");
        gc->setCellText("libxext");
        gc->setFillWidth(false);
        gc->setFilterString("libxext");
        formula->push_back(gc);

        gc = new GridCell();
        gc->setCellType("text");
        gc->setCellText("X.Org: Library for common extensions to the X11 protocol");
        gc->setFillWidth(true);
        gc->setFilterString("libxext");
        formula->push_back(gc);

        gc = new GridCell();
        gc->setCellType("text");
        gc->setCellText("homebrew/tap");
        gc->setFillWidth(false);
        gc->setFilterString("libxext");
        formula->push_back(gc);

        gc = new GridCell();
        gc->setCellType("text");
        gc->setCellText("1.3.5");
        gc->setFillWidth(false);
        gc->setFilterString("libxext");
        formula->push_back(gc);

        gc = new GridCell();
        gc->setCellType("checkbox");
        gc->setCellText("1.3.6");
        gc->setFillWidth(false);
        gc->setFilterString("libxext");
        gc->setOnToggled("libxext");
        formula->push_back(gc);

        gc = new GridCell();
        gc->setCellType("text");
        gc->setCellText(".");
        gc->setFillWidth(false);
        gc->setFilterString("libxext");
        gc->setHoverText("<h3>Used in</h3><p>item 1</p><h3>Used by</h3><p>item 2</p>");
        formula->push_back(gc);

        QVector<GridCell *> *services = &servicesBodyList();

        gc = new GridCell();
        gc->setCellType("text");
        gc->setCellText("unbound");
        gc->setFillWidth(false);
        gc->setFilterString("unbound");
        services->push_back(gc);

        gc = new GridCell();
        gc->setCellType("text");
        gc->setCellText("none");
        gc->setFillWidth(false);
        gc->setFilterString("unbound");
        services->push_back(gc);

        gc = new GridCell();
        gc->setCellType("text");
        gc->setCellText("");
        gc->setFillWidth(false);
        gc->setFilterString("unbound");
        services->push_back(gc);

        gc = new GridCell();
        gc->setCellType("text");
        gc->setCellText("/usr/local/opt/unbound/homebrew.mxcl.unbound.plist");
        gc->setFillWidth(true);
        gc->setFilterString("unbound");
        services->push_back(gc);

        gc = new GridCell();
        gc->setCellType("linkBtn");
        gc->setCellText("stop");
        gc->setFillWidth(false);
        gc->setFilterString("unbound");
        services->push_back(gc);
    }

public slots:
    void asyncRefreshData(const QJSValue &callback)
    {
        makeAsync<bool>(callback, [=]() {
            bool success = refreshData();
            if (success) {
                setLastUpdateDateStr("02-24 13:34");
                qDebug() << "setLast refresh date";                
            }
            return success;
        });
    }

    void saveBrewLocation(const QString s)
    {
        settings.setValue("brewLocation", s);
        loadBrewLocation();
    }

private:
    QSettings settings{"shemeshg", "Cakebrewjs2"};
    bool refreshData()
    {
        auto e = exec("/usr/local/bin/brew", {"-h"});
        return e.isSuccess;
    }

    const QString getFindExecutable(const QString &exec) const
    {
        auto full_path = QStandardPaths::findExecutable(exec);
        if (full_path.isEmpty()) {
            full_path = QStandardPaths::findExecutable(exec,
                                                       {"/usr/local/bin", "/opt/homebrew/bin"});
        }

        return full_path;
    }

    void loadBrewLocation()
    {
        QString s_brewLocation = settings.value("brewLocation", "").toString();
        if (s_brewLocation.isEmpty()) {
            s_brewLocation = getFindExecutable("brew");
            settings.setValue("brewLocation", s_brewLocation);
        }

        QFileInfo check_file(s_brewLocation);
        if (s_brewLocation.isEmpty() || !check_file.exists()) {
            s_brewLocation = "";
        }
        setBrewLocation(s_brewLocation);
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
