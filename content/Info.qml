import CakebrewJs2
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Core

ColumnLayout {        
    RowLayout {
        CoreComboBox {
            id: cmb
            model: ListModel {
                ListElement {
                    text: "Cask"
                }
                ListElement {
                    text: "Formula"
                }
            }
        }
        CoreTextField {
            text: ""
            Layout.fillWidth: true
            onActiveFocusChanged: {
                if (activeFocus) {
                    selectAll()
                }
            }
        }
        CoreButton {
            text: "Info"
        }

    }

    RowLayout {
        CoreLabel {
            text: "<h2>Joplin " + "2.14.19" + "</h2>"
        }
        Item {
            Layout.fillWidth: true
        }
        CoreLabel {
            text: "Cask joplin"
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
        text: "Note taking and to-do application with synchronisation capabilities"
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
        Label {
            text: " 180 Mb"
        }
    }
    Label {
        font.pointSize: Constants.fontSizeLarge3()
        font.bold: true
        topPadding: 20
        text: "Artifacts"

    }
    Label {
        text: "releaseOSX11_1.4.3/Midi router client.app (App)"
    }
    Label {
        text: "releaseOSX11_1.4.3/Midi router server.app (App)"
    }
    Label {
        font.pointSize: Constants.fontSizeLarge3()
        font.bold: true
        topPadding: 20
        text: "Analytics"
    }
    Label {
        text: "install: 6 (30 days), 11 (90 days), 46 (365 days)"
    }
}
