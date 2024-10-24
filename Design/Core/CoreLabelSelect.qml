import QtQuick

TextEdit {
    readOnly: true
    color: CoreSystemPalette.text
    selectionColor: CoreSystemPalette.highlight
    selectedTextColor: CoreSystemPalette.highlightedText
    textFormat: TextEdit.AutoText
    onActiveFocusChanged: {
        if (activeFocus) {
            selectAll()
        }
    }
}
