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
    RowLayout {
        CoreLabel {
            text: "Used in: "
            font.bold: true
        }
        CoreLabel {
            text: "brotli, c-ares, icu4c, libnghttp2, libuv, openssl@3"
        }
    }
    HyperlinkBtn {
        topPadding: 30
        urlRef: ""
        urlText: "Show brew info" // "Hide brew info" isShowBrewInfoText
    }
    CoreTextArea {
        text: `
==> jq: stable 1.7.1 (bottled), HEAD
Lightweight and flexible command-line JSON processor
https://jqlang.github.io/jq/
/usr/local/Cellar/jq/1.7.1 (19 files, 1.4MB) *
Poured from bottle using the formulae.brew.sh API on 2023-12-15 at 20:24:10
From: https://github.com/Homebrew/homebrew-core/blob/HEAD/Formula/j/jq.rb
License: MIT
==> Dependencies
Required: oniguruma ✔
==> Options
--HEAD
Install HEAD version
==> Analytics
install: 53,150 (30 days), 185,825 (90 days), 586,075 (365 days)
install-on-request: 52,523 (30 days), 183,498 (90 days), 577,860 (365 days)
build-error: 1 (30 days)
        `
    }
}
