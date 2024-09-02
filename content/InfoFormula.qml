import CakebrewJs2
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Core

ColumnLayout {
    property string token: ""
    property string fullName: ""
    property string desc: ""
    property string version: ""
    property string outdated: ""
    property string cellarSize: ""
    property bool isOutdated: false
    property bool isInstalled: false
    property bool isPinned: false
    property bool isDeprecated: false
    property string homepage: ""
    property string caskRbGithub: ""
    property string license: ""
    property string caveats: ""
    property var usedIn: []
    property var buildDependencies: []
    property var dependencies: []
    property bool showBrewUses: false
    property var brewUses: []

    RowLayout {
        CoreLabel {
            font.pointSize: Constants.fontSizeLarge3()
            font.bold: true
            topPadding: 20
            text: fullName + " " + (isPinned ? "📌 " : "") + (isDeprecated ? "⚠️ " : "") + outdated
        }
        Item {
            Layout.fillWidth: true
        }
        CoreLabel {
            text: "Formula: "
        }
        HyperlinkBtnInfo {
            isCask: false
            leftPadding: 10
            urlText: token
            urlRef: token
            rightPadding: 10
        }
    }

    CoreLabel {
        topPadding: 5
        text: desc
    }

    RowLayout {
        Layout.topMargin: 5
        visible: isInstalled
        CoreLabel {
            text: isOutdated ? "outdated " : "installed "
            color: CoreSystemPalette.isDarkTheme ? "Light green" : "Dark green"
        }
        CoreLabel {
            text: version
            color: CoreSystemPalette.isDarkTheme ? "Light green" : "Dark green"
        }
        CoreLabel {
            text: cellarSize
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

    RowLayout {
        CoreLabel {
            topPadding: 15
            text: "License: "
            font.bold: true
        }
        CoreLabel {
            topPadding: 15
            text: license
        }
    }

    CoreLabel {
        font.pointSize: Constants.fontSizeLarge3()
        font.bold: true
        topPadding: 15
        text: "Dependencies"
    }
    RowLayout {
        CoreLabel {
            text: "Build: "
            font.bold: true
        }
        RowLayout {
            Repeater {
                model: buildDependencies
                delegate: HyperlinkBtnInfo {
                    isCask: false
                    leftPadding: 10
                    urlText: modelData
                    urlRef: modelData
                }
            }
        }
    }
    RowLayout {
        CoreLabel {
            text: "Required: "
            font.bold: true
        }
        RowLayout {
            Repeater {
                model: dependencies
                delegate: HyperlinkBtnInfo {
                    isCask: false
                    leftPadding: 10
                    urlText: modelData
                    urlRef: modelData
                }
            }
        }
    }
    RowLayout {
        CoreLabel {
            text: "Used in: "
            font.bold: true
        }
        RowLayout {
            Repeater {
                model: usedIn

                delegate: HyperlinkBtnInfo {
                    isCask: false
                    leftPadding: 10
                    urlText: modelData
                    urlRef: modelData
                }
            }
        }
    }
    RowLayout {
        visible: showBrewUses
        CoreLabel {
            text: "Brew uses: "
            font.bold: true
        }
        RowLayout {
            Repeater {
                model: brewUses

                delegate: HyperlinkBtnInfo {
                    isCask: false
                    leftPadding: 10
                    urlText: modelData
                    urlRef: modelData
                }
            }
        }
    }
    CoreLabel {
        font.pointSize: Constants.fontSizeLarge3()
        font.bold: true
        topPadding: 15
        text: "Caveats"
        visible: caveats
    }
    CoreTextArea {
        visible: caveats
        readOnly: true
        Layout.fillWidth: true
        text: caveats
    }
}
