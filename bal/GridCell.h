#pragma once

#include <QObject>
#include <QObjectComputedProperty>
#include <QQmlEngine>

/*[[[cog
import cog
from GridCell import classGridCell


cog.outl(classGridCell.getClassHeader(),
        dedent=True, trimblanklines=True)

]]] */
class GridCell : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QString cellType READ cellType WRITE setCellType NOTIFY cellTypeChanged )
    Q_PROPERTY(QString cellText READ cellText WRITE setCellText NOTIFY cellTextChanged )
    Q_PROPERTY(bool fillWidth READ fillWidth WRITE setFillWidth NOTIFY fillWidthChanged )
    Q_PROPERTY(QString filterString READ filterString WRITE setFilterString NOTIFY filterStringChanged )
    Q_PROPERTY(QString onToggled READ onToggled WRITE setOnToggled NOTIFY onToggledChanged )
    Q_PROPERTY(QString hoverText READ hoverText WRITE setHoverText NOTIFY hoverTextChanged )
    
    QML_ELEMENT
public:
    GridCell(QObject *parent = nullptr);

    
    
    QString cellType() const{return m_cellType;} 
    
void setCellType(const QString &newCellType)
    {
        if (m_cellType == newCellType)
            return;
        m_cellType = newCellType;
        emit cellTypeChanged();
    }


    
    QString cellText() const{return m_cellText;} 
    
void setCellText(const QString &newCellText)
    {
        if (m_cellText == newCellText)
            return;
        m_cellText = newCellText;
        emit cellTextChanged();
    }


    
    bool fillWidth() const{return m_fillWidth;} 
    
void setFillWidth(const bool newFillWidth)
    {
        if (m_fillWidth == newFillWidth)
            return;
        m_fillWidth = newFillWidth;
        emit fillWidthChanged();
    }


    
    QString filterString() const{return m_filterString;} 
    
void setFilterString(const QString &newFilterString)
    {
        if (m_filterString == newFilterString)
            return;
        m_filterString = newFilterString;
        emit filterStringChanged();
    }


    
    QString onToggled() const{return m_onToggled;} 
    
void setOnToggled(const QString &newOnToggled)
    {
        if (m_onToggled == newOnToggled)
            return;
        m_onToggled = newOnToggled;
        emit onToggledChanged();
    }


    
    QString hoverText() const{return m_hoverText;} 
    
void setHoverText(const QString &newHoverText)
    {
        if (m_hoverText == newHoverText)
            return;
        m_hoverText = newHoverText;
        emit hoverTextChanged();
    }



signals:
    void cellTypeChanged();
    void cellTextChanged();
    void fillWidthChanged();
    void filterStringChanged();
    void onToggledChanged();
    void hoverTextChanged();
    

private:
    QString m_cellType;
    QString m_cellText;
    bool m_fillWidth;
    QString m_filterString;
    QString m_onToggled;
    QString m_hoverText;
    
    void ctorClass();
};

//[[[end]]]


