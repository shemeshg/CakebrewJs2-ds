import QtQuick
import QtQuick.Controls


ToolTip {
    id: toolTip
    contentItem: Text {
        color: CoreSystemPalette.text

        text: toolTip.text
        font: CoreSystemPalette.font //Constants.fontSizeNormal()
    }
    background: Rectangle {
        color: CoreSystemPalette.base
    }
}
