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
        urlRef: "https://nodejs.org/"
        urlText: "https://nodejs.org/"
    }

    HyperlinkBtn {
        urlRef: "https://github.com/Homebrew/homebrew-core/blob/HEAD/Formula/n/node.rb"
        urlText: "https://github.com/Homebrew/homebrew-core/blob/HEAD/Formula/n/node.rb"
    }

    RowLayout {
        CoreLabel {
            topPadding: 15
            text: "License: "
            font.bold: true
        }
        CoreLabel {
            topPadding: 15
            text: "MIT"
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
        CoreLabel {
            text: "pkg-config ,python@3.12"
        }
    }
    RowLayout {
        CoreLabel {
            text: "Required: "
            font.bold: true
        }
        CoreLabel {
            text: "brotli, c-ares, icu4c, libnghttp2, libuv, openssl@3"
        }
    }
}
