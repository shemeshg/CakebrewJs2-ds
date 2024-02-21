import CakebrewJs2
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

ColumnLayout {
    property string itemName: ""
    property string itemTag: ""
    property string itemVer: ""
    property bool itemIsInstalled: false
    property string itemUrl: ""
    property string itemDesk: ""

    RowLayout {

        Label {
            text: "•"
            color: Constants.systemPalette.text
        }
        Label {
            id: textStart
            text: itemName + " ( "
            color: Constants.systemPalette.text
        }
        HyperlinkBtn {
            urlText: itemTag
        }
        Label {
            text: " ) " + itemVer
            color: Constants.systemPalette.text
        }
        Label {
            visible: itemIsInstalled
            text: " installed"
            color: Constants.systemPalette.isDarkTheme ? "Light green" : "Dark green"
        }
        Label {
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
        Label {
            leftPadding: 20
            text: itemDesk
            color: Constants.systemPalette.text
        }
    }
}
