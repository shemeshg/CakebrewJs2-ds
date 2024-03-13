import CakebrewJs2
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Core

ColumnLayout {

    RowLayout {
        CoreLabel {
            font.pointSize: Constants.fontSizeLarge3()
            font.bold: true
            topPadding: 20
            text: "Node " + "21.7.1"
        }
        Item {
            Layout.fillWidth: true
        }
        CoreLabel {
            text: "Formula: node "
        }
    }

    RowLayout {
        CoreLabel {
            text: "outdated "
            color: CoreSystemPalette.isDarkTheme ? "Light green" : "Dark green"
        }
        CoreLabel {
            text: "21.6.2_1"
            color: CoreSystemPalette.isDarkTheme ? "Light green" : "Dark green"
        }
    }

    CoreLabel {
        topPadding: 5
        text: "Platform built on V8 to build network applications"
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
    RowLayout {
        HyperlinkBtn {
            urlRef: "file://usr/local/Cellar/node/21.6.2_1"
            urlText: "/usr/local/Cellar/node/21.6.2_1"
        }
        CoreLabel {
            text: " 64.5 Mb"
        }
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
            text: "MIT: "
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

    RowLayout {
        CoreLabel {
            text: "install-on-request: "
            font.bold: true
        }
        CoreLabel {
            text: "6 (30 days), 11 (90 days), 46 (365 days)"
        }
    }
    RowLayout {
        CoreLabel {
            text: "build-error: "
            font.bold: true
        }
        CoreLabel {
            text: "417 (30 days)"
        }
    }

}
