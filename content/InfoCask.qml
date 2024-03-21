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
    property string caskRbGithub: ""
    property string caskroomSize: ""
    property string artifacts: ""

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

    CoreLabel {
        topPadding: 5
        text: desc
        font.pointSize: Constants.fontSizeLarge2()
    }

    RowLayout {
        Layout.topMargin: 5
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

        CoreLabel {
            text: caskroomSize
        }
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
        onLinkActivated: Qt.openUrlExternally(link)
    }

    HyperlinkBtn {
        urlRef: caskRbGithub
        urlText: caskRbGithub
        onLinkActivated: Qt.openUrlExternally(link)
    }

    CoreLabel {
        font.pointSize: Constants.fontSizeLarge3()
        font.bold: true
        topPadding: 15
        text: "Artifacts"
    }
    CoreLabel {
        text: artifacts
    }
}
