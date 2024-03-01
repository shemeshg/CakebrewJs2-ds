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
    Q_PROPERTY(QVector<SearchResultRow *> searchItemsCask READ searchItemsCask  NOTIFY searchItemsCaskChanged )
    Q_PROPERTY(QVector<SearchResultRow *> searchItemsFormula READ searchItemsFormula  NOTIFY searchItemsFormulaChanged )
    Q_PROPERTY(QString searchStatusCaskText READ searchStatusCaskText WRITE setSearchStatusCaskText NOTIFY searchStatusCaskTextChanged )
    Q_PROPERTY(QString searchStatusFormulaText READ searchStatusFormulaText WRITE setSearchStatusFormulaText NOTIFY searchStatusFormulaTextChanged )
    Q_PROPERTY(bool searchStatusCaskVisible READ searchStatusCaskVisible WRITE setSearchStatusCaskVisible NOTIFY searchStatusCaskVisibleChanged )
    Q_PROPERTY(bool searchStatusFormulaVisible READ searchStatusFormulaVisible WRITE setSearchStatusFormulaVisible NOTIFY searchStatusFormulaVisibleChanged )
    Q_PROPERTY(bool searchCaskRunning READ searchCaskRunning WRITE setSearchCaskRunning NOTIFY searchCaskRunningChanged )
    Q_PROPERTY(bool searchFormulaRunning READ searchFormulaRunning WRITE setSearchFormulaRunning NOTIFY searchFormulaRunningChanged )
    
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



signals:
    void lastUpdateDateStrChanged();
    void caskBodyListChanged();
    void formulaBodyListChanged();
    void servicesBodyListChanged();
    void brewLocationChanged();
    void normalFontPointSizeChanged();
    void searchItemsCaskChanged();
    void searchItemsFormulaChanged();
    void searchStatusCaskTextChanged();
    void searchStatusFormulaTextChanged();
    void searchStatusCaskVisibleChanged();
    void searchStatusFormulaVisibleChanged();
    void searchCaskRunningChanged();
    void searchFormulaRunningChanged();
    

private:
    QString m_lastUpdateDateStr;
    QVector<GridCell *> m_caskBodyList;
    QVector<GridCell *> m_formulaBodyList;
    QVector<GridCell *> m_servicesBodyList;
    QString m_brewLocation;
    QString m_normalFontPointSize;
    QVector<SearchResultRow *> m_searchItemsCask;
    QVector<SearchResultRow *> m_searchItemsFormula;
    QString m_searchStatusCaskText;
    QString m_searchStatusFormulaText;
    bool m_searchStatusCaskVisible;
    bool m_searchStatusFormulaVisible;
    bool m_searchCaskRunning;
    bool m_searchFormulaRunning;
    
    void ctorClass();
};

//[[[end]]]


