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
    property string homepage: ""
    property string caskRbGithub: ""
    property string license: ""
    property var usedIn: []
    property var buildDependencies: []
    property var dependencies: []

    RowLayout {
        CoreLabel {
            font.pointSize: Constants.fontSizeLarge3()
            font.bold: true
            topPadding: 20
            text: fullName + " " + version
        }
        Item {
            Layout.fillWidth: true
        }
        CoreLabel {
            text: "Formula: " + token + " "
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
            text: outdated
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
    }

    HyperlinkBtn {
        urlRef: caskRbGithub
        urlText: caskRbGithub
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
                delegate:  CoreLabel {
                    text: modelData
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
                delegate:  CoreLabel {
                    text: modelData
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
                delegate:  CoreLabel {
                    text: modelData
                }
            }
        }
    }
}
