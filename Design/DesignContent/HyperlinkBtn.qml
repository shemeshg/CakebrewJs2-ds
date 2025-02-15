import Design
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Core

CoreLabel {
    property string urlRef: "_"
    property string urlText: "_"
    id: hyperlinkBtn
    text: urlText
    color: CoreSystemPalette.isDarkTheme ? "Light blue" : "Dark blue"

    MouseArea {
        anchors.fill: parent
        cursorShape: Qt.PointingHandCursor
        onClicked: () => {
                       hyperlinkBtn.linkActivated(urlRef)
                   }
    }
}
