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
//-only-file header
class BrewDataPrivate : public JsAsync
{
    Q_OBJECT
    Q_PROPERTY(QString brewLocation READ brewLocation WRITE setBrewLocation NOTIFY brewLocationChanged )
    Q_PROPERTY(QString normalFontPointSize READ normalFontPointSize WRITE setNormalFontPointSize NOTIFY normalFontPointSizeChanged )
    Q_PROPERTY(QString terminalApp READ terminalApp WRITE setTerminalApp NOTIFY terminalAppChanged )
    Q_PROPERTY(bool updateForce READ updateForce WRITE setUpdateForce NOTIFY updateForceChanged )
    Q_PROPERTY(int x READ x WRITE setX NOTIFY xChanged )
    Q_PROPERTY(int y READ y WRITE setY NOTIFY yChanged )
    Q_PROPERTY(int width READ width WRITE setWidth NOTIFY widthChanged )
    Q_PROPERTY(int height READ height WRITE setHeight NOTIFY heightChanged )
    Q_PROPERTY(bool isExtendedCask READ isExtendedCask WRITE setIsExtendedCask NOTIFY isExtendedCaskChanged )
    Q_PROPERTY(bool isExtendedFormula READ isExtendedFormula WRITE setIsExtendedFormula NOTIFY isExtendedFormulaChanged )
    Q_PROPERTY(bool isExtendedService READ isExtendedService WRITE setIsExtendedService NOTIFY isExtendedServiceChanged )
    Q_PROPERTY(bool isShowBrewInfoText READ isShowBrewInfoText WRITE setIsShowBrewInfoText NOTIFY isShowBrewInfoTextChanged )
    Q_PROPERTY(QStringList selfSignList READ selfSignList WRITE setSelfSignList NOTIFY selfSignListChanged )
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
    Q_PROPERTY(InfoStatus infoStatus READ infoStatus WRITE setInfoStatus NOTIFY infoStatusChanged )
    Q_PROPERTY(QString infoToken READ infoToken WRITE setInfoToken NOTIFY infoTokenChanged )
    Q_PROPERTY(bool isInfoShowPin READ isInfoShowPin WRITE setIsInfoShowPin NOTIFY isInfoShowPinChanged )
    Q_PROPERTY(bool isInfoShowUnpin READ isInfoShowUnpin WRITE setIsInfoShowUnpin NOTIFY isInfoShowUnpinChanged )
    Q_PROPERTY(bool isInfoShowUpgrade READ isInfoShowUpgrade WRITE setIsInfoShowUpgrade NOTIFY isInfoShowUpgradeChanged )
    Q_PROPERTY(bool isInfoShowInstall READ isInfoShowInstall WRITE setIsInfoShowInstall NOTIFY isInfoShowInstallChanged )
    Q_PROPERTY(bool isInfoShowUninstall READ isInfoShowUninstall WRITE setIsInfoShowUninstall NOTIFY isInfoShowUninstallChanged )
    Q_PROPERTY(bool isInfoShowUninstallZap READ isInfoShowUninstallZap WRITE setIsInfoShowUninstallZap NOTIFY isInfoShowUninstallZapChanged )
    
    QML_ELEMENT
public:
    
    BrewDataPrivate(QObject *parent):JsAsync(parent){}

    virtual ~BrewDataPrivate() {
        
    }

    
enum class InfoStatus {
        Idile, Running, CaskFound, FormulaFound, CaskNotFound, FormulaNotFound
    };
Q_ENUM(InfoStatus)

    
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


    
    bool updateForce() const{return m_updateForce;} 
    
void setUpdateForce(const bool newUpdateForce)
    {
        if (m_updateForce == newUpdateForce)
            return;
        m_updateForce = newUpdateForce;
        emit updateForceChanged();
    }


    
    int x() const{return m_x;} 
    
void setX(const int newX)
    {
        if (m_x == newX)
            return;
        m_x = newX;
        emit xChanged();
    }


    
    int y() const{return m_y;} 
    
void setY(const int newY)
    {
        if (m_y == newY)
            return;
        m_y = newY;
        emit yChanged();
    }


    
    int width() const{return m_width;} 
    
void setWidth(const int newWidth)
    {
        if (m_width == newWidth)
            return;
        m_width = newWidth;
        emit widthChanged();
    }


    
    int height() const{return m_height;} 
    
void setHeight(const int newHeight)
    {
        if (m_height == newHeight)
            return;
        m_height = newHeight;
        emit heightChanged();
    }


    
    bool isExtendedCask() const{return m_isExtendedCask;} 
    
void setIsExtendedCask(const bool newIsExtendedCask)
    {
        if (m_isExtendedCask == newIsExtendedCask)
            return;
        m_isExtendedCask = newIsExtendedCask;
        emit isExtendedCaskChanged();
    }


    
    bool isExtendedFormula() const{return m_isExtendedFormula;} 
    
void setIsExtendedFormula(const bool newIsExtendedFormula)
    {
        if (m_isExtendedFormula == newIsExtendedFormula)
            return;
        m_isExtendedFormula = newIsExtendedFormula;
        emit isExtendedFormulaChanged();
    }


    
    bool isExtendedService() const{return m_isExtendedService;} 
    
void setIsExtendedService(const bool newIsExtendedService)
    {
        if (m_isExtendedService == newIsExtendedService)
            return;
        m_isExtendedService = newIsExtendedService;
        emit isExtendedServiceChanged();
    }


    
    bool isShowBrewInfoText() const{return m_isShowBrewInfoText;} 
    
void setIsShowBrewInfoText(const bool newIsShowBrewInfoText)
    {
        if (m_isShowBrewInfoText == newIsShowBrewInfoText)
            return;
        m_isShowBrewInfoText = newIsShowBrewInfoText;
        emit isShowBrewInfoTextChanged();
    }


    
    QStringList selfSignList() const{return m_selfSignList;} 
    
void setSelfSignList(const QStringList &newSelfSignList)
    {
        if (m_selfSignList == newSelfSignList)
            return;
        m_selfSignList = newSelfSignList;
        emit selfSignListChanged();
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
    

    
    InfoStatus infoStatus() const{return m_infoStatus;} 
    
void setInfoStatus(const InfoStatus &newInfoStatus)
    {
        if (m_infoStatus == newInfoStatus)
            return;
        m_infoStatus = newInfoStatus;
        emit infoStatusChanged();
    }


    
    QString infoToken() const{return m_infoToken;} 
    
void setInfoToken(const QString &newInfoToken)
    {
        if (m_infoToken == newInfoToken)
            return;
        m_infoToken = newInfoToken;
        emit infoTokenChanged();
    }


    
    bool isInfoShowPin() const{return m_isInfoShowPin;} 
    
void setIsInfoShowPin(const bool newIsInfoShowPin)
    {
        if (m_isInfoShowPin == newIsInfoShowPin)
            return;
        m_isInfoShowPin = newIsInfoShowPin;
        emit isInfoShowPinChanged();
    }


    
    bool isInfoShowUnpin() const{return m_isInfoShowUnpin;} 
    
void setIsInfoShowUnpin(const bool newIsInfoShowUnpin)
    {
        if (m_isInfoShowUnpin == newIsInfoShowUnpin)
            return;
        m_isInfoShowUnpin = newIsInfoShowUnpin;
        emit isInfoShowUnpinChanged();
    }


    
    bool isInfoShowUpgrade() const{return m_isInfoShowUpgrade;} 
    
void setIsInfoShowUpgrade(const bool newIsInfoShowUpgrade)
    {
        if (m_isInfoShowUpgrade == newIsInfoShowUpgrade)
            return;
        m_isInfoShowUpgrade = newIsInfoShowUpgrade;
        emit isInfoShowUpgradeChanged();
    }


    
    bool isInfoShowInstall() const{return m_isInfoShowInstall;} 
    
void setIsInfoShowInstall(const bool newIsInfoShowInstall)
    {
        if (m_isInfoShowInstall == newIsInfoShowInstall)
            return;
        m_isInfoShowInstall = newIsInfoShowInstall;
        emit isInfoShowInstallChanged();
    }


    
    bool isInfoShowUninstall() const{return m_isInfoShowUninstall;} 
    
void setIsInfoShowUninstall(const bool newIsInfoShowUninstall)
    {
        if (m_isInfoShowUninstall == newIsInfoShowUninstall)
            return;
        m_isInfoShowUninstall = newIsInfoShowUninstall;
        emit isInfoShowUninstallChanged();
    }


    
    bool isInfoShowUninstallZap() const{return m_isInfoShowUninstallZap;} 
    
void setIsInfoShowUninstallZap(const bool newIsInfoShowUninstallZap)
    {
        if (m_isInfoShowUninstallZap == newIsInfoShowUninstallZap)
            return;
        m_isInfoShowUninstallZap = newIsInfoShowUninstallZap;
        emit isInfoShowUninstallZapChanged();
    }


    
    
    
signals:
    void brewLocationChanged();
    void normalFontPointSizeChanged();
    void terminalAppChanged();
    void updateForceChanged();
    void xChanged();
    void yChanged();
    void widthChanged();
    void heightChanged();
    void isExtendedCaskChanged();
    void isExtendedFormulaChanged();
    void isExtendedServiceChanged();
    void isShowBrewInfoTextChanged();
    void selfSignListChanged();
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
    void infoStatusChanged();
    void infoTokenChanged();
    void isInfoShowPinChanged();
    void isInfoShowUnpinChanged();
    void isInfoShowUpgradeChanged();
    void isInfoShowInstallChanged();
    void isInfoShowUninstallChanged();
    void isInfoShowUninstallZapChanged();
    

protected:
    QVector<SearchResultRow *> m_searchItemsCask ;
    QVector<SearchResultRow *> m_searchItemsFormula ;
    QVariantList m_formulaTableBodyList ;
    QVariantList m_caskTableBodyList ;
    QVariantList m_serviceTableBodyList ;
    

private:
    QString m_brewLocation ;
    QString m_normalFontPointSize ;
    QString m_terminalApp ;
    bool m_updateForce = false;
    int m_x = 0;
    int m_y = 0;
    int m_width = 0;
    int m_height = 0;
    bool m_isExtendedCask = false;
    bool m_isExtendedFormula = false;
    bool m_isExtendedService = false;
    bool m_isShowBrewInfoText = false;
    QStringList m_selfSignList ;
    QString m_searchStatusCaskText ;
    QString m_searchStatusFormulaText ;
    bool m_searchStatusCaskVisible = false;
    bool m_searchStatusFormulaVisible = false;
    bool m_searchCaskRunning = false;
    bool m_searchFormulaRunning = false;
    QString m_refreshStatusCaskText ;
    QString m_refreshStatusFormulaText ;
    QString m_refreshStatusServiceText ;
    bool m_refreshStatusServiceVisible = false;
    bool m_refreshStatusFormulaVisible = false;
    bool m_refreshStatusCaskVisible = false;
    bool m_refreshServiceRunning = false;
    bool m_refreshFormulaRunning = false;
    bool m_refreshCaskRunning = false;
    int m_serviceSortedColIdx = 0;
    int m_serviceSortedColOrder = 0;
    int m_caskSortedColIdx = 0;
    int m_caskSortedColOrder = 0;
    int m_formulaSortedColIdx = 0;
    int m_formulaSortedColOrder = 0;
    InfoStatus m_infoStatus ;
    QString m_infoToken ;
    bool m_isInfoShowPin = false;
    bool m_isInfoShowUnpin = false;
    bool m_isInfoShowUpgrade = false;
    bool m_isInfoShowInstall = false;
    bool m_isInfoShowUninstall = false;
    bool m_isInfoShowUninstallZap = false;
    
};
//-only-file null

//[[[end]]]


