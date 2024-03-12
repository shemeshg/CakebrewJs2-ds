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
            text: "Joplin " + "2.14.19"
        }
        Item {
            Layout.fillWidth: true
        }
        CoreLabel {
            text: "Cask: joplin "
        }
    }

    RowLayout {
        CoreLabel {
            text: "outdated "
            color: CoreSystemPalette.isDarkTheme ? "Light green" : "Dark green"
        }
        CoreLabel {
            text: "2.14.17"
            color: CoreSystemPalette.isDarkTheme ? "Light green" : "Dark green"
        }
    }

    CoreLabel {
        topPadding: 5
        text: "Note taking and to-do application with synchronisation capabilities"
    }

    CoreLabel {
        font.pointSize: Constants.fontSizeLarge3()
        font.bold: true
        topPadding: 15
        text: "Links"

    }
    HyperlinkBtn {
        urlRef: "https://joplinapp.org/"
        urlText: "https://joplinapp.org/"
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
        urlRef: "https://github.com/Homebrew/homebrew-cask/blob/HEAD/Casks/j/joplin.rb"
        urlText: "https://github.com/Homebrew/homebrew-cask/blob/HEAD/Casks/j/joplin.rb"
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
    CoreLabel {
        text: "install: 6 (30 days), 11 (90 days), 46 (365 days)"
    }
}
