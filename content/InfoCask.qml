import CakebrewJs2
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Core

ColumnLayout {
    property string token: ""
    property string version: ""
    property string outdated: ""
    property string name: ""
    property string desc: ""
    property string homepage: ""
    property string caskRbGithub: "asdf"
    property bool isOutdated: false
    property bool isInstalled: false

    RowLayout {
        CoreLabel {
            font.pointSize: Constants.fontSizeLarge3()
            font.bold: true
            topPadding: 20
            text: name + " " + outdated
        }
        Item {
            Layout.fillWidth: true
        }
        CoreLabel {
            text: "Cask: " + token + " "
        }
    }

    RowLayout {
        visible: isInstalled
        CoreLabel {
            text: isOutdated ? "outdated " : "installed "
            color: CoreSystemPalette.isDarkTheme ? "Light green" : "Dark green"
        }
        CoreLabel {
            visible: isOutdated
            text: version
            color: CoreSystemPalette.isDarkTheme ? "Light green" : "Dark green"
        }
    }

    CoreLabel {
        topPadding: 5
        text: desc
    }

    CoreLabel {
        font.pointSize: Constants.fontSizeLarge3()
        font.bold: true
        topPadding: 15
        text: "Links"
    }
    HyperlinkBtn {
        urlRef: homepage
        urlText: homepage
    }
    RowLayout {
        HyperlinkBtn {
            urlRef: "file://usr/local/Caskroom/joplin/2.14.17"
            urlText: "/usr/local/Caskroom/joplin/2.14.17"
        }
        CoreLabel {
            text: " 180 Mb"
        }
    }

    HyperlinkBtn {
        urlRef: caskRbGithub
        urlText: caskRbGithub
    }

    CoreLabel {
        font.pointSize: Constants.fontSizeLarge3()
        font.bold: true
        topPadding: 15
        text: "Artifacts"
    }
    CoreLabel {
        text: "releaseOSX11_1.4.3/Midi router client.app (App)"
    }
    CoreLabel {
        text: "releaseOSX11_1.4.3/Midi router server.app (App)"
    }
    CoreLabel {
        font.pointSize: Constants.fontSizeLarge3()
        font.bold: true
        topPadding: 15
        text: "Analytics"
    }
    RowLayout {
        CoreLabel {
            text: "install: "
            font.bold: true
        }
        CoreLabel {
            text: "6 (30 days), 11 (90 days), 46 (365 days)"
        }
    }
}
