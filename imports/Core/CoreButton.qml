import QtQuick
import QtQuick.Controls
import CakebrewJs2

Button {
    id: btn
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

    palette.alternateBase : CoreSystemPalette.alternateBase
    palette.base : CoreSystemPalette.base
    palette.button : CoreSystemPalette.button
    palette.buttonText : CoreSystemPalette.buttonText
    palette.dark : CoreSystemPalette.dark
    palette.highlight : CoreSystemPalette.highlight
    palette.highlightedText : CoreSystemPalette.highlightedText
    palette.light : CoreSystemPalette.light
    palette.mid : CoreSystemPalette.mid
    palette.midlight : CoreSystemPalette.midlight
    palette.placeholderText : CoreSystemPalette.placeholderText
    palette.shadow : CoreSystemPalette.shadow
    palette.text : CoreSystemPalette.text
    palette.window : CoreSystemPalette.window
    palette.windowText : CoreSystemPalette.windowText

    font.pointSize: Constants.fontSizeNormal()
}
