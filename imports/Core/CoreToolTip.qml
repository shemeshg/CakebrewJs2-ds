import QtQuick
import QtQuick.Controls
import CakebrewJs2

ToolTip {
    id: toolTip
    contentItem: Text {
        color: CoreSystemPalette.text

        text: toolTip.text
        font.pointSize: Constants.fontSizeNormal()
    }
    background: Rectangle {
        color: CoreSystemPalette.base
    }
}
