import QtQuick
import QtQuick.Controls


TextField {

    onActiveFocusChanged: {
        if (activeFocus) {
            selectAll()
        }
    }

    palette.alternateBase: CoreSystemPalette.alternateBase
    palette.base: CoreSystemPalette.base
    palette.button: CoreSystemPalette.button
    palette.buttonText: CoreSystemPalette.buttonText
    palette.dark: CoreSystemPalette.dark
    palette.highlight: CoreSystemPalette.highlight
    palette.highlightedText: CoreSystemPalette.highlightedText
    palette.light: CoreSystemPalette.light
    palette.mid: CoreSystemPalette.mid
    palette.midlight: CoreSystemPalette.midlight
    palette.placeholderText: CoreSystemPalette.placeholderText
    palette.shadow: CoreSystemPalette.shadow
    palette.text: CoreSystemPalette.text
    palette.window: CoreSystemPalette.window
    palette.windowText: CoreSystemPalette.windowText

    font:  CoreSystemPalette.font
}
