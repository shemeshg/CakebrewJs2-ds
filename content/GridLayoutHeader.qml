import CakebrewJs2
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Core

CoreLabel {
    id: gridLayoutHeader
    enum SortOrder {
           No,
           Asc,
           Dsc
     }
    property  string headerText: ""
    property int sortOrder:  GridLayoutHeader.SortOrder.No
    signal headerClicked

    function getOrderSymble(){
        if (sortOrder === GridLayoutHeader.SortOrder.Asc){
            return " ↑"
        } else if (sortOrder === GridLayoutHeader.SortOrder.Dsc){
            return " ↓"
        } else {
            return ""
        }

    }


    text: "<h4>" + headerText + getOrderSymble()  + "</h4>"
    color : Constants.systemPalette.text
    Layout.rightMargin:  20
    MouseArea {
        anchors.fill: parent
        cursorShape: Qt.PointingHandCursor
        onClicked: ()=>{
                       gridLayoutHeader.headerClicked()
                   }
    }
}
