#pragma once
#include "BrewDataPrivate.h"
#include "CaskRow.h"
#include "FormulaRow.h"
#include "ServiceRow.h"
#include "shellcmd.h"

class BrewData : public BrewDataPrivate

{
    Q_OBJECT
    QML_ELEMENT
public:
    explicit BrewData(QObject *parent = nullptr);

signals:
    void addSearchRow(SearchResultRow *row, bool isCask);
    void parseRefreshServicesSignal(QString strResult);
    void parseRefreshCaskAndFormulaSignal(QString strResult);

public slots:
    QString qtVer() { return QT_VERSION_STR; }
    void asyncSearch(const QJSValue &callback, QString textSearch, bool isCask);

    void asyncBrewActionSelected(QStringList casks,
                                 QStringList formulas,
                                 QString action,
                                 const QJSValue &callback);

    void asyncBrewUpgradeSelected(QStringList casks, QStringList formulas, const QJSValue &callback);

    void asyncBrewUpgradeAll(const QJSValue &callback);

    void asyncBrewDoctor(const QJSValue &callback);

    void asyncBrewCleanup(const QJSValue &callback);

    void asyncServiceAction(const QJSValue &callback, QString name, QString action);

    void asyncRefreshServices(const QJSValue &callback, bool loadFromCash = false);

    void asyncPin(QString token, const QJSValue &callback);

    void asyncUnpin(QString token, const QJSValue &callback);

    void asyncGetBrewVersion(const QJSValue &callback);

    void asyncRefreshCaskAndFormula(bool doBrewUpdate,
                                    const QJSValue &callback,
                                    bool loadFromCash = false);

    void saveTerminalApp(const QString s);

    void saveUpdateForce(const bool s);
    void savePauseTerminalClose(const bool s);
    

    void saveNormalFontPointSize(const QString s);

    void saveBrewLocation(const QString s);

    void saveIsExtendedCask(const bool s);
    void saveIsExtendedFormula(const bool s);
    void saveIsExtendedService(const bool s);
    void saveIsShowBrewInfoText(const bool s);
    void saveSelfSignList(const QStringList s);

    void saveX(const int s);
    void saveY(const int s);
    void saveWidth(const int s);
    void saveHeight(const int s);

    void asyncFormulaSort(const QJSValue &callback);

    void formulaSort();

    void asyncCaskSort(const QJSValue &callback);

    void caskSort();

    void asyncGetBrewUses(QString token, const QJSValue &callback);
    QStringList getBrewUses(QString token);

    void asyncGetInfoText(QString token, bool isCask, const QJSValue &callback);

    QString getInfoText(const QString token, bool isCask);

    void asyncGetInfo(QString token, bool isCask, const QJSValue &callback);

    QVariant getInfo(const QString token, bool isCask);

    void selfSignCasks(const QString token, const QJSValue &callback);

    void asyncServiceSort(const QJSValue &callback);

    void serviceSort();

private slots:
    void parseRefreshServices(QString strResult);

    void parseRefreshCaskAndFormula(QString strResult);

private:
    QSettings settings;

    QVector<ServiceRow> serviceRows = {};
    QVector<CaskRow> caskRows ={};
    QVector<FormulaRow> formulaRows = {};

    const QString getFindExecutable(const QString &exec) const;

    void loadNormalFontPointSize();

    void loadTerminalApp();
    void loadUpdateForce();
    void loadPauseTerminalClose();
        

    void loadBrewLocation();

    void loadIsExtendedCask();
    void loadIsExtendedFormula();
    void loadIsExtendedService();
    void loadIsShowBrewInfoText();
    void loadSelfSignList();
    void loadX();
    void loadY();
    void loadWidth();
    void loadHeight();

    void refreshCaskAndFormulaBeforeCallback();

    void refreshCaskAndFormulaAfterCallback(bool doBrewUpdate);

    void refreshServicesBeforeCallback();

    void refreshServicesAfterCallback();

    void setRowFromCaskRow(QMap<QString, QVariant> &row, CaskRow &caskRow);

    void setRowFromFormulaRow(QMap<QString, QVariant> &row, FormulaRow &formulaRow);

    void cashFileWrite(const QString &fileName, QString &fileContent);
    QString cashFileRead(const QString &fileName);
    ShellCmd getShellCmd();
    const QString getSelfSignCaskCmdStr(const QString token);
    const QString getSelfSignCaskForPotentialItems(QStringList casks);
};
