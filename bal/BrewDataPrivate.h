#pragma once

#include <QObject>
#include <QObjectComputedProperty>
#include <QQmlEngine>
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
    Q_PROPERTY(QString refreshStatusServiceText READ refreshStatusServiceText WRITE setRefreshStatusServiceText NOTIFY refreshStatusServiceTextChanged )
    Q_PROPERTY(bool refreshStatusServiceVisible READ refreshStatusServiceVisible WRITE setRefreshStatusServiceVisible NOTIFY refreshStatusServiceVisibleChanged )
    Q_PROPERTY(bool refreshStatusFormulaVisible READ refreshStatusFormulaVisible WRITE setRefreshStatusFormulaVisible NOTIFY refreshStatusFormulaVisibleChanged )
    Q_PROPERTY(bool refreshStatusCaskVisible READ refreshStatusCaskVisible WRITE setRefreshStatusCaskVisible NOTIFY refreshStatusCaskVisibleChanged )
    Q_PROPERTY(bool refreshServiceRunning READ refreshServiceRunning WRITE setRefreshServiceRunning NOTIFY refreshServiceRunningChanged )
    Q_PROPERTY(bool refreshFormulaRunning READ refreshFormulaRunning WRITE setRefreshFormulaRunning NOTIFY refreshFormulaRunningChanged )
    Q_PROPERTY(bool refreshCaskRunning READ refreshCaskRunning WRITE setRefreshCaskRunning NOTIFY refreshCaskRunningChanged )
    Q_PROPERTY(int serviceSortedColIdx READ serviceSortedColIdx WRITE setServiceSortedColIdx NOTIFY serviceSortedColIdxChanged )
    Q_PROPERTY(int serviceSortedColOrder READ serviceSortedColOrder WRITE setServiceSortedColOrder NOTIFY serviceSortedColOrderChanged )
    Q_PROPERTY(int caskSortedColIdx READ caskSortedColIdx WRITE setCaskSortedColIdx NOTIFY caskSortedColIdxChanged )
    Q_PROPERTY(int caskSortedColOrder READ caskSortedColOrder WRITE setCaskSortedColOrder NOTIFY caskSortedColOrderChanged )
    Q_PROPERTY(int formulaSortedColIdx READ formulaSortedColIdx WRITE setFormulaSortedColIdx NOTIFY formulaSortedColIdxChanged )
    Q_PROPERTY(int formulaSortedColOrder READ formulaSortedColOrder WRITE setFormulaSortedColOrder NOTIFY formulaSortedColOrderChanged )
    Q_PROPERTY(QVariantList formulaTableBodyList READ formulaTableBodyList  NOTIFY formulaTableBodyListChanged )
    Q_PROPERTY(QVariantList caskTableBodyList READ caskTableBodyList  NOTIFY caskTableBodyListChanged )
    Q_PROPERTY(QVariantList serviceTableBodyList READ serviceTableBodyList  NOTIFY serviceTableBodyListChanged )
    
    QML_ELEMENT
public:
    BrewDataPrivate(QObject *parent = nullptr);

    
    
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


    
    QString refreshStatusServiceText() const{return m_refreshStatusServiceText;} 
    
void setRefreshStatusServiceText(const QString &newRefreshStatusServiceText)
    {
        if (m_refreshStatusServiceText == newRefreshStatusServiceText)
            return;
        m_refreshStatusServiceText = newRefreshStatusServiceText;
        emit refreshStatusServiceTextChanged();
    }


    
    bool refreshStatusServiceVisible() const{return m_refreshStatusServiceVisible;} 
    
void setRefreshStatusServiceVisible(const bool newRefreshStatusServiceVisible)
    {
        if (m_refreshStatusServiceVisible == newRefreshStatusServiceVisible)
            return;
        m_refreshStatusServiceVisible = newRefreshStatusServiceVisible;
        emit refreshStatusServiceVisibleChanged();
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


    
    bool refreshServiceRunning() const{return m_refreshServiceRunning;} 
    
void setRefreshServiceRunning(const bool newRefreshServiceRunning)
    {
        if (m_refreshServiceRunning == newRefreshServiceRunning)
            return;
        m_refreshServiceRunning = newRefreshServiceRunning;
        emit refreshServiceRunningChanged();
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


    
    int serviceSortedColIdx() const{return m_serviceSortedColIdx;} 
    
void setServiceSortedColIdx(const int newServiceSortedColIdx)
    {
        if (m_serviceSortedColIdx == newServiceSortedColIdx)
            return;
        m_serviceSortedColIdx = newServiceSortedColIdx;
        emit serviceSortedColIdxChanged();
    }


    
    int serviceSortedColOrder() const{return m_serviceSortedColOrder;} 
    
void setServiceSortedColOrder(const int newServiceSortedColOrder)
    {
        if (m_serviceSortedColOrder == newServiceSortedColOrder)
            return;
        m_serviceSortedColOrder = newServiceSortedColOrder;
        emit serviceSortedColOrderChanged();
    }


    
    int caskSortedColIdx() const{return m_caskSortedColIdx;} 
    
void setCaskSortedColIdx(const int newCaskSortedColIdx)
    {
        if (m_caskSortedColIdx == newCaskSortedColIdx)
            return;
        m_caskSortedColIdx = newCaskSortedColIdx;
        emit caskSortedColIdxChanged();
    }


    
    int caskSortedColOrder() const{return m_caskSortedColOrder;} 
    
void setCaskSortedColOrder(const int newCaskSortedColOrder)
    {
        if (m_caskSortedColOrder == newCaskSortedColOrder)
            return;
        m_caskSortedColOrder = newCaskSortedColOrder;
        emit caskSortedColOrderChanged();
    }


    
    int formulaSortedColIdx() const{return m_formulaSortedColIdx;} 
    
void setFormulaSortedColIdx(const int newFormulaSortedColIdx)
    {
        if (m_formulaSortedColIdx == newFormulaSortedColIdx)
            return;
        m_formulaSortedColIdx = newFormulaSortedColIdx;
        emit formulaSortedColIdxChanged();
    }


    
    int formulaSortedColOrder() const{return m_formulaSortedColOrder;} 
    
void setFormulaSortedColOrder(const int newFormulaSortedColOrder)
    {
        if (m_formulaSortedColOrder == newFormulaSortedColOrder)
            return;
        m_formulaSortedColOrder = newFormulaSortedColOrder;
        emit formulaSortedColOrderChanged();
    }


    
    QVariantList &formulaTableBodyList() {return m_formulaTableBodyList;} 
    

    
    QVariantList &caskTableBodyList() {return m_caskTableBodyList;} 
    

    
    QVariantList &serviceTableBodyList() {return m_serviceTableBodyList;} 
    

enum class InfoStatus {
        Idile, Running, CaskFound, FormulaFound, CaskNotFound, FormulaNotFound
    };
Q_ENUM(InfoStatus)


signals:
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
    void refreshStatusServiceTextChanged();
    void refreshStatusServiceVisibleChanged();
    void refreshStatusFormulaVisibleChanged();
    void refreshStatusCaskVisibleChanged();
    void refreshServiceRunningChanged();
    void refreshFormulaRunningChanged();
    void refreshCaskRunningChanged();
    void serviceSortedColIdxChanged();
    void serviceSortedColOrderChanged();
    void caskSortedColIdxChanged();
    void caskSortedColOrderChanged();
    void formulaSortedColIdxChanged();
    void formulaSortedColOrderChanged();
    void formulaTableBodyListChanged();
    void caskTableBodyListChanged();
    void serviceTableBodyListChanged();
    

private:
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
    QString m_refreshStatusServiceText;
    bool m_refreshStatusServiceVisible;
    bool m_refreshStatusFormulaVisible;
    bool m_refreshStatusCaskVisible;
    bool m_refreshServiceRunning;
    bool m_refreshFormulaRunning;
    bool m_refreshCaskRunning;
    int m_serviceSortedColIdx;
    int m_serviceSortedColOrder;
    int m_caskSortedColIdx;
    int m_caskSortedColOrder;
    int m_formulaSortedColIdx;
    int m_formulaSortedColOrder;
    QVariantList m_formulaTableBodyList;
    QVariantList m_caskTableBodyList;
    QVariantList m_serviceTableBodyList;
    
    void ctorClass();
};

//[[[end]]]


