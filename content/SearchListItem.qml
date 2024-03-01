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
            font.pointSize: Constants.fontSizeLarge3()
        }
        CoreLabel {
            id: textStart
            text: itemName + " ( "
            font.pointSize: Constants.fontSizeLarge3()
        }
        HyperlinkBtn {
            urlText: itemTag
            font.pointSize: Constants.fontSizeLarge3()
        }
        CoreLabel {
            text: " ) " + itemVer
            font.pointSize: Constants.fontSizeLarge3()
        }
        CoreLabel {
            visible: itemIsInstalled
            text: " installed"
            color: CoreSystemPalette.isDarkTheme ? "Light green" : "Dark green"
            font.pointSize: Constants.fontSizeLarge3()
        }
    }
    RowLayout {
        CoreLabel {
            leftPadding: 20
            text: itemDesk
            color: CoreSystemPalette.text
            font.pointSize: Constants.fontSizeLarge2()
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
