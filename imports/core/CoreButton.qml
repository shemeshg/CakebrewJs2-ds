import QtQuick
import QtQuick.Controls

Button {
    property string hooverText: ""

    CoreToolTip {
        id: toolTip
    }
    HoverHandler {
        id: hoverHandler
        onHoveredChanged: {
            if (!hovered)
                toolTip.hide()
        }
    }

    onHoveredChanged: {
        if (hooverText) {
            toolTip.show(hooverText, 3000)
        }
    }
    palette.buttonText: CoreSystemPalette.buttonText
}
