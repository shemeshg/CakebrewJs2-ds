import QtQuick
import QtQuick.Controls

ToolTip {
    id: toolTip
    contentItem: Text {
        color: CoreSystemPalette.text

        text: toolTip.text
    }
    background: Rectangle {
        color: CoreSystemPalette.base
    }
}
