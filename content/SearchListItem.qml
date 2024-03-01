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

    property string itemFilterBy: ""

    RowLayout {        
        CoreLabel {
            text: "•"
        }
        CoreLabel {
            id: textStart
            text: itemName + " ( "
        }
        HyperlinkBtn {
            urlText: itemTag
        }
        CoreLabel {
            text: " ) " + itemVer
        }
        CoreLabel {
            visible: itemIsInstalled
            text: " installed"
            color: CoreSystemPalette.isDarkTheme ? "Light green" : "Dark green"
        }
    }
    RowLayout {
        CoreLabel {
            leftPadding: 20
            text: itemDesk
            color: CoreSystemPalette.text
        }
    }
    RowLayout {
        HyperlinkBtn {
            leftPadding: 20
            urlRef: itemUrl
            urlText: itemUrl
            onLinkActivated: link => {
                                 Qt.openUrlExternally(link)
                             }
        }
    }


}
