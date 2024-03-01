import CakebrewJs2
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Core

ColumnLayout {
    property string itemName: ""
    property string itemTag: ""
    property string itemVer: ""
    property bool itemIsInstalled: false
    property string itemUrl: ""
    property string itemDesk: ""

    RowLayout {

        CoreLabel {
            text: "•"
        }
        CoreLabel {
            id: textStart
            text: itemName + " ( "
            color: CoreSystemPalette.text
        }
        HyperlinkBtn {
            urlText: itemTag
        }
        CoreLabel {
            text: " ) " + itemVer
            color: CoreSystemPalette.text
        }
        CoreLabel {
            visible: itemIsInstalled
            text: " installed"
            color: CoreSystemPalette.isDarkTheme ? "Light green" : "Dark green"
        }
        CoreLabel {
            text: " - "
            color: CoreSystemPalette.text
        }
        HyperlinkBtn {
            urlRef: itemUrl
            urlText: itemUrl
            onLinkActivated: link => {
                                 Qt.openUrlExternally(link)
                             }
        }
    }
    RowLayout {
        CoreLabel {
            leftPadding: 20
            text: itemDesk
            color: CoreSystemPalette.text
        }
    }
}
