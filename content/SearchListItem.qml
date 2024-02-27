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
            color: Constants.systemPalette.text
        }
        CoreLabel {
            id: textStart
            text: itemName + " ( "
            color: Constants.systemPalette.text
        }
        HyperlinkBtn {
            urlText: itemTag
        }
        CoreLabel {
            text: " ) " + itemVer
            color: Constants.systemPalette.text
        }
        CoreLabel {
            visible: itemIsInstalled
            text: " installed"
            color: Constants.systemPalette.isDarkTheme ? "Light green" : "Dark green"
        }
        CoreLabel {
            text: " - "
            color: Constants.systemPalette.text
        }
        HyperlinkBtn {
            urlRef: itemUrl
            urlText: itemUrl
            onLinkActivated: Qt.openUrlExternally(link)
        }
    }
    RowLayout {
        CoreLabel {
            leftPadding: 20
            text: itemDesk
            color: Constants.systemPalette.text
        }
    }
}
