import QtQuick 2.15
import QtQuick.Controls 2.15


CheckBox {
    id: control
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
    indicator: Rectangle {
        function getColor(isChecked, isEnabled){
             if (isChecked){
                if(control.enabled) {
                 return palette.text
                } else {
                    return CoreSystemPalette.placeholderText
                }
             }
             else {
              return   "transparent"
             }
        }

        function getBorderColor(isEnabled){
            if(isEnabled) {
             return palette.text
            } else {
                return CoreSystemPalette.placeholderText
            }
        }

        implicitWidth: 20
        implicitHeight: 20
        radius: 4
        color: getColor(control.checked, control.enabled)
        border.color: getBorderColor(control.enabled)  // Removes black border
        border.width: 2
    }
    font: CoreSystemPalette.font
}
