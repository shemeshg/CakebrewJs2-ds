import CakebrewJs2
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

RowLayout {
    property bool isExtended: true
    property string headerText: ""

    Label {
        id: s1
        text: "<h1>" + "⏵ " + headerText + "</h1>"
        color: Constants.systemPalette.text
        visible: !isExtended
        MouseArea {
            anchors.fill: parent
            cursorShape: Qt.PointingHandCursor
            onClicked: isExtended = !isExtended
        }
    }
    Label {
        text: "<h1>" + "⏷ " + headerText + "</h1>"
        color: Constants.systemPalette.text
        visible: isExtended
        MouseArea {
            anchors.fill: parent
            cursorShape: Qt.PointingHandCursor
            onClicked: isExtended = !isExtended
        }
    }
}
