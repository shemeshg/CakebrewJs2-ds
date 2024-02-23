import CakebrewJs2
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

GridLayout {
    columns: 6
    Layout.margins: 20
    signal clicked(idx: int)
    id: homeFormulaGrid
    property var headerList: [
        "Name",
        "Desk",
        "Tap",
        "Version",
        "outdated",
        "Leaf"
    ]

    property var bodyList: [
        {cellType: "text", cellText: "libxext", fillWidth: false},
        {cellType: "text",
            cellText: "X.Org: Library for common extensions to the X11 protocol",
            fillWidth: true
        },
        {cellType: "text", cellText: "homebrew/tap", fillWidth: false},
        {cellType: "text", cellText: "1.3.5", fillWidth: false},
        {cellType: "checkbox", cellText: "1.3.6", fillWidth: false},
        {cellType: "text", cellText: ".", fillWidth: false},
    ]
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
        }
    }



}
