import Design
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Core

RowLayout {
    property bool isExtended: true
    property string headerText: ""
    property bool isLoading: false

    CoreLabel {
        id: s1
        text: "<h2>" + "⏵ " + headerText + "</h2>"
        color: CoreSystemPalette.text
        visible: !isExtended
        MouseArea {
            anchors.fill: parent
            cursorShape: Qt.PointingHandCursor
            onClicked: isExtended = !isExtended
        }
    }
    CoreLabel {
        text: "<h2>" + "⏷ " + headerText + "</h2>"
        color: CoreSystemPalette.text
        visible: isExtended
        MouseArea {
            anchors.fill: parent
            cursorShape: Qt.PointingHandCursor
            onClicked: isExtended = !isExtended
        }
    }

    CoreBusyIndicator {
        visible: isLoading
        Layout.alignment: Qt.AlignTop
    }
}
