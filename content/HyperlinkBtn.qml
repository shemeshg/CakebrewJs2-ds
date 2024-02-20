import CakebrewJs2
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Label {
    property string urlRef: "_"
    property string urlText: "_"
    id: hyperlinkBtn
    text: `
    <a href="` + urlRef + `">` + urlText + `</a>
    `

    MouseArea {
        anchors.fill: parent
        acceptedButtons: Qt.NoButton // Don't eat the mouse clicks
        cursorShape: Qt.PointingHandCursor
    }
}
