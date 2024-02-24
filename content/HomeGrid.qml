import CakebrewJs2
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

GridLayout {
    columns: headerList.length
    Layout.margins: 20
    signal clicked(idx: int)
    id: homeFormulaGrid
    property var headerList: []

    property var bodyList: []
    property int sortedColIdx: -1
    property int sortedColOrder: GridLayoutHeader.SortOrder.No

    Repeater {
        model: headerList
        delegate: GridLayoutHeader {
            headerText: modelData
            sortOrder: sortedColIdx === index ? sortedColOrder : GridLayoutHeader.SortOrder.No
            onClicked: {
                homeFormulaGrid.clicked(index)
            }
        }
    }


    Repeater {
        model: bodyList
        delegate: RowLayout {
            Label {
                visible: !modelData.fillWidth && modelData.cellType === "text"
                text: modelData.cellText
                color : Constants.systemPalette.text
            }
            Label {
                text: modelData.cellText
                visible: modelData.fillWidth && modelData.cellType === "text"
                color : Constants.systemPalette.text
                wrapMode: Text.WordWrap
                Layout.fillWidth: true
            }
            CheckBox {
                visible: modelData.cellType === "checkbox"
                text: modelData.cellText
            }
            HyperlinkBtn {
                visible: modelData.cellType === "linkBtn"
                urlText: modelData.cellText
            }
        }
    }



}
