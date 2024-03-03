#pragma once

#include <QObject>
#include <QObjectComputedProperty>
#include <QQmlEngine>
#include "GridCell.h"
#include "JsAsync.h"
#include "searchresultrow.h"
/*[[[cog
import cog
from BrewDataPrivate import classBrewDataPrivate


cog.outl(classBrewDataPrivate.getClassHeader(),
        dedent=True, trimblanklines=True)

]]] */
class BrewDataPrivate : public JsAsync
{
    Q_OBJECT
    Q_PROPERTY(QString lastUpdateDateStr READ lastUpdateDateStr WRITE setLastUpdateDateStr NOTIFY lastUpdateDateStrChanged )
    Q_PROPERTY(QVector<GridCell *> caskBodyList READ caskBodyList  NOTIFY caskBodyListChanged )
    Q_PROPERTY(QVector<GridCell *> formulaBodyList READ formulaBodyList  NOTIFY formulaBodyListChanged )
    Q_PROPERTY(QVector<GridCell *> servicesBodyList READ servicesBodyList  NOTIFY servicesBodyListChanged )
    Q_PROPERTY(QString brewLocation READ brewLocation WRITE setBrewLocation NOTIFY brewLocationChanged )
    Q_PROPERTY(QString normalFontPointSize READ normalFontPointSize WRITE setNormalFontPointSize NOTIFY normalFontPointSizeChanged )
    Q_PROPERTY(QString terminalApp READ terminalApp WRITE setTerminalApp NOTIFY terminalAppChanged )
    Q_PROPERTY(QVector<SearchResultRow *> searchItemsCask READ searchItemsCask  NOTIFY searchItemsCaskChanged )
    Q_PROPERTY(QVector<SearchResultRow *> searchItemsFormula READ searchItemsFormula  NOTIFY searchItemsFormulaChanged )
    Q_PROPERTY(QString searchStatusCaskText READ searchStatusCaskText WRITE setSearchStatusCaskText NOTIFY searchStatusCaskTextChanged )
    Q_PROPERTY(QString searchStatusFormulaText READ searchStatusFormulaText WRITE setSearchStatusFormulaText NOTIFY searchStatusFormulaTextChanged )
    Q_PROPERTY(bool searchStatusCaskVisible READ searchStatusCaskVisible WRITE setSearchStatusCaskVisible NOTIFY searchStatusCaskVisibleChanged )
    Q_PROPERTY(bool searchStatusFormulaVisible READ searchStatusFormulaVisible WRITE setSearchStatusFormulaVisible NOTIFY searchStatusFormulaVisibleChanged )
    Q_PROPERTY(bool searchCaskRunning READ searchCaskRunning WRITE setSearchCaskRunning NOTIFY searchCaskRunningChanged )
    Q_PROPERTY(bool searchFormulaRunning READ searchFormulaRunning WRITE setSearchFormulaRunning NOTIFY searchFormulaRunningChanged )
    Q_PROPERTY(QString refreshStatusCaskText READ refreshStatusCaskText WRITE setRefreshStatusCaskText NOTIFY refreshStatusCaskTextChanged )
    Q_PROPERTY(QString refreshStatusFormulaText READ refreshStatusFormulaText WRITE setRefreshStatusFormulaText NOTIFY refreshStatusFormulaTextChanged )
    Q_PROPERTY(QString refreshStatusServicesText READ refreshStatusServicesText WRITE setRefreshStatusServicesText NOTIFY refreshStatusServicesTextChanged )
    Q_PROPERTY(bool refreshStatusServicesVisible READ refreshStatusServicesVisible WRITE setRefreshStatusServicesVisible NOTIFY refreshStatusServicesVisibleChanged )
    Q_PROPERTY(bool refreshStatusFormulaVisible READ refreshStatusFormulaVisible WRITE setRefreshStatusFormulaVisible NOTIFY refreshStatusFormulaVisibleChanged )
    Q_PROPERTY(bool refreshStatusCaskVisible READ refreshStatusCaskVisible WRITE setRefreshStatusCaskVisible NOTIFY refreshStatusCaskVisibleChanged )
    Q_PROPERTY(bool refreshServicesRunning READ refreshServicesRunning WRITE setRefreshServicesRunning NOTIFY refreshServicesRunningChanged )
    Q_PROPERTY(bool refreshFormulaRunning READ refreshFormulaRunning WRITE setRefreshFormulaRunning NOTIFY refreshFormulaRunningChanged )
    Q_PROPERTY(bool refreshCaskRunning READ refreshCaskRunning WRITE setRefreshCaskRunning NOTIFY refreshCaskRunningChanged )
    
    QML_ELEMENT
public:
    BrewDataPrivate(QObject *parent = nullptr);

    
    
    QString lastUpdateDateStr() const{return m_lastUpdateDateStr;} 
    
void setLastUpdateDateStr(const QString &newLastUpdateDateStr)
    {
        if (m_lastUpdateDateStr == newLastUpdateDateStr)
            return;
        m_lastUpdateDateStr = newLastUpdateDateStr;
        emit lastUpdateDateStrChanged();
    }


    
    QVector<GridCell *> &caskBodyList() {return m_caskBodyList;} 
    

    
    QVector<GridCell *> &formulaBodyList() {return m_formulaBodyList;} 
    

    
    QVector<GridCell *> &servicesBodyList() {return m_servicesBodyList;} 
    

    
    QString brewLocation() const{return m_brewLocation;} 
    
void setBrewLocation(const QString &newBrewLocation)
    {
        if (m_brewLocation == newBrewLocation)
            return;
        m_brewLocation = newBrewLocation;
        emit brewLocationChanged();
    }


    
    QString normalFontPointSize() const{return m_normalFontPointSize;} 
    
void setNormalFontPointSize(const QString &newNormalFontPointSize)
    {
        if (m_normalFontPointSize == newNormalFontPointSize)
            return;
        m_normalFontPointSize = newNormalFontPointSize;
        emit normalFontPointSizeChanged();
    }


    
    QString terminalApp() const{return m_terminalApp;} 
    
void setTerminalApp(const QString &newTerminalApp)
    {
        if (m_terminalApp == newTerminalApp)
            return;
        m_terminalApp = newTerminalApp;
        emit terminalAppChanged();
    }


    
    QVector<SearchResultRow *> &searchItemsCask() {return m_searchItemsCask;} 
    

    
    QVector<SearchResultRow *> &searchItemsFormula() {return m_searchItemsFormula;} 
    

    
    QString searchStatusCaskText() const{return m_searchStatusCaskText;} 
    
void setSearchStatusCaskText(const QString &newSearchStatusCaskText)
    {
        if (m_searchStatusCaskText == newSearchStatusCaskText)
            return;
        m_searchStatusCaskText = newSearchStatusCaskText;
        emit searchStatusCaskTextChanged();
    }


    
    QString searchStatusFormulaText() const{return m_searchStatusFormulaText;} 
    
void setSearchStatusFormulaText(const QString &newSearchStatusFormulaText)
    {
        if (m_searchStatusFormulaText == newSearchStatusFormulaText)
            return;
        m_searchStatusFormulaText = newSearchStatusFormulaText;
        emit searchStatusFormulaTextChanged();
    }


    
    bool searchStatusCaskVisible() const{return m_searchStatusCaskVisible;} 
    
void setSearchStatusCaskVisible(const bool newSearchStatusCaskVisible)
    {
        if (m_searchStatusCaskVisible == newSearchStatusCaskVisible)
            return;
        m_searchStatusCaskVisible = newSearchStatusCaskVisible;
        emit searchStatusCaskVisibleChanged();
    }


    
    bool searchStatusFormulaVisible() const{return m_searchStatusFormulaVisible;} 
    
void setSearchStatusFormulaVisible(const bool newSearchStatusFormulaVisible)
    {
        if (m_searchStatusFormulaVisible == newSearchStatusFormulaVisible)
            return;
        m_searchStatusFormulaVisible = newSearchStatusFormulaVisible;
        emit searchStatusFormulaVisibleChanged();
    }


    
    bool searchCaskRunning() const{return m_searchCaskRunning;} 
    
void setSearchCaskRunning(const bool newSearchCaskRunning)
    {
        if (m_searchCaskRunning == newSearchCaskRunning)
            return;
        m_searchCaskRunning = newSearchCaskRunning;
        emit searchCaskRunningChanged();
    }


    
    bool searchFormulaRunning() const{return m_searchFormulaRunning;} 
    
void setSearchFormulaRunning(const bool newSearchFormulaRunning)
    {
        if (m_searchFormulaRunning == newSearchFormulaRunning)
            return;
        m_searchFormulaRunning = newSearchFormulaRunning;
        emit searchFormulaRunningChanged();
    }


    
    QString refreshStatusCaskText() const{return m_refreshStatusCaskText;} 
    
void setRefreshStatusCaskText(const QString &newRefreshStatusCaskText)
    {
        if (m_refreshStatusCaskText == newRefreshStatusCaskText)
            return;
        m_refreshStatusCaskText = newRefreshStatusCaskText;
        emit refreshStatusCaskTextChanged();
    }


    
    QString refreshStatusFormulaText() const{return m_refreshStatusFormulaText;} 
    
void setRefreshStatusFormulaText(const QString &newRefreshStatusFormulaText)
    {
        if (m_refreshStatusFormulaText == newRefreshStatusFormulaText)
            return;
        m_refreshStatusFormulaText = newRefreshStatusFormulaText;
        emit refreshStatusFormulaTextChanged();
    }


    
    QString refreshStatusServicesText() const{return m_refreshStatusServicesText;} 
    
void setRefreshStatusServicesText(const QString &newRefreshStatusServicesText)
    {
        if (m_refreshStatusServicesText == newRefreshStatusServicesText)
            return;
        m_refreshStatusServicesText = newRefreshStatusServicesText;
        emit refreshStatusServicesTextChanged();
    }


    
    bool refreshStatusServicesVisible() const{return m_refreshStatusServicesVisible;} 
    
void setRefreshStatusServicesVisible(const bool newRefreshStatusServicesVisible)
    {
        if (m_refreshStatusServicesVisible == newRefreshStatusServicesVisible)
            return;
        m_refreshStatusServicesVisible = newRefreshStatusServicesVisible;
        emit refreshStatusServicesVisibleChanged();
    }


    
    bool refreshStatusFormulaVisible() const{return m_refreshStatusFormulaVisible;} 
    
void setRefreshStatusFormulaVisible(const bool newRefreshStatusFormulaVisible)
    {
        if (m_refreshStatusFormulaVisible == newRefreshStatusFormulaVisible)
            return;
        m_refreshStatusFormulaVisible = newRefreshStatusFormulaVisible;
        emit refreshStatusFormulaVisibleChanged();
    }


    
    bool refreshStatusCaskVisible() const{return m_refreshStatusCaskVisible;} 
    
void setRefreshStatusCaskVisible(const bool newRefreshStatusCaskVisible)
    {
        if (m_refreshStatusCaskVisible == newRefreshStatusCaskVisible)
            return;
        m_refreshStatusCaskVisible = newRefreshStatusCaskVisible;
        emit refreshStatusCaskVisibleChanged();
    }


    
    bool refreshServicesRunning() const{return m_refreshServicesRunning;} 
    
void setRefreshServicesRunning(const bool newRefreshServicesRunning)
    {
        if (m_refreshServicesRunning == newRefreshServicesRunning)
            return;
        m_refreshServicesRunning = newRefreshServicesRunning;
        emit refreshServicesRunningChanged();
    }


    
    bool refreshFormulaRunning() const{return m_refreshFormulaRunning;} 
    
void setRefreshFormulaRunning(const bool newRefreshFormulaRunning)
    {
        if (m_refreshFormulaRunning == newRefreshFormulaRunning)
            return;
        m_refreshFormulaRunning = newRefreshFormulaRunning;
        emit refreshFormulaRunningChanged();
    }


    
    bool refreshCaskRunning() const{return m_refreshCaskRunning;} 
    
void setRefreshCaskRunning(const bool newRefreshCaskRunning)
    {
        if (m_refreshCaskRunning == newRefreshCaskRunning)
            return;
        m_refreshCaskRunning = newRefreshCaskRunning;
        emit refreshCaskRunningChanged();
    }



signals:
    void lastUpdateDateStrChanged();
    void caskBodyListChanged();
    void formulaBodyListChanged();
    void servicesBodyListChanged();
    void brewLocationChanged();
    void normalFontPointSizeChanged();
    void terminalAppChanged();
    void searchItemsCaskChanged();
    void searchItemsFormulaChanged();
    void searchStatusCaskTextChanged();
    void searchStatusFormulaTextChanged();
    void searchStatusCaskVisibleChanged();
    void searchStatusFormulaVisibleChanged();
    void searchCaskRunningChanged();
    void searchFormulaRunningChanged();
    void refreshStatusCaskTextChanged();
    void refreshStatusFormulaTextChanged();
    void refreshStatusServicesTextChanged();
    void refreshStatusServicesVisibleChanged();
    void refreshStatusFormulaVisibleChanged();
    void refreshStatusCaskVisibleChanged();
    void refreshServicesRunningChanged();
    void refreshFormulaRunningChanged();
    void refreshCaskRunningChanged();
    

private:
    QString m_lastUpdateDateStr;
    QVector<GridCell *> m_caskBodyList;
    QVector<GridCell *> m_formulaBodyList;
    QVector<GridCell *> m_servicesBodyList;
    QString m_brewLocation;
    QString m_normalFontPointSize;
    QString m_terminalApp;
    QVector<SearchResultRow *> m_searchItemsCask;
    QVector<SearchResultRow *> m_searchItemsFormula;
    QString m_searchStatusCaskText;
    QString m_searchStatusFormulaText;
    bool m_searchStatusCaskVisible;
    bool m_searchStatusFormulaVisible;
    bool m_searchCaskRunning;
    bool m_searchFormulaRunning;
    QString m_refreshStatusCaskText;
    QString m_refreshStatusFormulaText;
    QString m_refreshStatusServicesText;
    bool m_refreshStatusServicesVisible;
    bool m_refreshStatusFormulaVisible;
    bool m_refreshStatusCaskVisible;
    bool m_refreshServicesRunning;
    bool m_refreshFormulaRunning;
    bool m_refreshCaskRunning;
    
    void ctorClass();
};

//[[[end]]]


