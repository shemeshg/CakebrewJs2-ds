pragma Singleton

import QtQuick

SystemPalette {
    id: systemPalette
        function isDarkColor(hex) {
            // Convert hex color to RGB values
            let r = parseInt(hex.slice(1, 3), 16)
            let g = parseInt(hex.slice(3, 5), 16)
            let b = parseInt(hex.slice(5, 7), 16)

            // Calculate luminance
            let l = 0.2126 * r + 0.7152 * g + 0.0722 * b

            // Return true if luminance is less than 128, false otherwise
            return l < 128
        }

        colorGroup: SystemPalette.Active

        property bool isDarkTheme: !isDarkColor(systemPalette.text.toString())
    }
