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
    void asyncSearch(const QJSValue &callback, QString textSearch, bool isCask);

    void asyncBrewActionSelected(QStringList casks,
                                 QStringList formulas,
                                 QString action,
                                 const QJSValue &callback);

    void asyncBrewUpgradeSelected(QStringList casks, QStringList formulas, const QJSValue &callback);

    void asyncBrewUpgradeAll(const QJSValue &callback);

    void asyncBrewDoctor(const QJSValue &callback);

    void asyncServiceAction(const QJSValue &callback, QString name, QString action);

    void asyncRefreshServices(const QJSValue &callback);

    void asyncPin(QString token, const QJSValue &callback);

    void asyncUnpin(QString token, const QJSValue &callback);

    void asyncRefreshCaskAndFormula(bool doBrewUpdate, const QJSValue &callback);

    void saveTerminalApp(const QString s);

    void saveNormalFontPointSize(const QString s);

    void saveBrewLocation(const QString s);

    void asyncFormulaSort(const QJSValue &callback);

    void formulaSort();

    void asyncCaskSort(const QJSValue &callback);

    void caskSort();

    void asyncGetInfoText(QString token, bool isCask, const QJSValue &callback);

    QString getInfoText(const QString token, bool isCask);

    void asyncGetInfo(QString token, bool isCask, const QJSValue &callback);

    QVariant getInfo(const QString token, bool isCask);

    void asyncServiceSort(const QJSValue &callback);

    void serviceSort();

private slots:
    void parseRefreshServices(QString strResult);

    void parseRefreshCaskAndFormula(QString strResult);

private:
    QSettings settings{"shemeshg", "Cakebrewjs2"};

    QVector<ServiceRow> serviceRows;
    QVector<CaskRow> caskRows;
    QVector<FormulaRow> formulaRows;

    const QString getFindExecutable(const QString &exec) const;

    void loadNormalFontPointSize();

    void loadTerminalApp();

    void loadBrewLocation();

    void refreshCaskAndFormulaBeforeCallback();

    void refreshCaskAndFormulaAfterCallback(bool doBrewUpdate);

    void refreshServicesBeforeCallback();

    void refreshServicesAfterCallback();

    void setRowFromCaskRow(QMap<QString, QVariant> &row, CaskRow &caskRow);

    void setRowFromFormulaRow(QMap<QString, QVariant> &row, FormulaRow &formulaRow);

    ShellCmd getShellCmd();
};
