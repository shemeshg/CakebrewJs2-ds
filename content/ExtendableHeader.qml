import CakebrewJs2
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Core

RowLayout {
    property bool isExtended: true
    property string headerText: ""

    CoreLabel {
        id: s1
        text: "<h1>" + "⏵ " + headerText + "</h1>"
        color: CoreSystemPalette.text
        visible: !isExtended
        MouseArea {
            anchors.fill: parent
            cursorShape: Qt.PointingHandCursor
            onClicked: isExtended = !isExtended
        }
    }
    CoreLabel {
        text: "<h1>" + "⏷ " + headerText + "</h1>"
        color: CoreSystemPalette.text
        visible: isExtended
        MouseArea {
            anchors.fill: parent
            cursorShape: Qt.PointingHandCursor
            onClicked: isExtended = !isExtended
        }
    }
}
