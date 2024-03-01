#pragma once
#include <QObject>
#include <QObjectComputedProperty>
#include <QQmlEngine>

/*[[[cog
import cog
from SearchResultRow import classSearchResultRow


cog.outl(classSearchResultRow.getClassHeader(),
        dedent=True, trimblanklines=True)

]]] */
class SearchResultRow : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QString token READ token WRITE setToken NOTIFY tokenChanged )
    Q_PROPERTY(QString name READ name WRITE setName NOTIFY nameChanged )
    Q_PROPERTY(QString version READ version WRITE setVersion NOTIFY versionChanged )
    Q_PROPERTY(QString homepage READ homepage WRITE setHomepage NOTIFY homepageChanged )
    Q_PROPERTY(QString desc READ desc WRITE setDesc NOTIFY descChanged )
    Q_PROPERTY(bool installed READ installed WRITE setInstalled NOTIFY installedChanged )
    
    QML_ELEMENT
public:
    SearchResultRow(QObject *parent = nullptr);

    QString token() const { return m_token; }

    void setToken(const QString &newToken)
    {
        if (m_token == newToken)
            return;
        m_token = newToken;
        emit tokenChanged();
    }


    
    QString name() const{return m_name;} 
    
void setName(const QString &newName)
    {
        if (m_name == newName)
            return;
        m_name = newName;
        emit nameChanged();
    }


    
    QString version() const{return m_version;} 
    
void setVersion(const QString &newVersion)
    {
        if (m_version == newVersion)
            return;
        m_version = newVersion;
        emit versionChanged();
    }


    
    QString homepage() const{return m_homepage;} 
    
void setHomepage(const QString &newHomepage)
    {
        if (m_homepage == newHomepage)
            return;
        m_homepage = newHomepage;
        emit homepageChanged();
    }


    
    QString desc() const{return m_desc;} 
    
void setDesc(const QString &newDesc)
    {
        if (m_desc == newDesc)
            return;
        m_desc = newDesc;
        emit descChanged();
    }


    
    bool installed() const{return m_installed;} 
    
void setInstalled(const bool newInstalled)
    {
        if (m_installed == newInstalled)
            return;
        m_installed = newInstalled;
        emit installedChanged();
    }



signals:
    void tokenChanged();
    void nameChanged();
    void versionChanged();
    void homepageChanged();
    void descChanged();
    void installedChanged();
    

private:
    QString m_token;
    QString m_name;
    QString m_version;
    QString m_homepage;
    QString m_desc;
    bool m_installed;
    
    void ctorClass();
};

//[[[end]]]
