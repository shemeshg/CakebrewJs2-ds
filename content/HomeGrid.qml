import CakebrewJs2
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

GridLayout {
    columns: headerList.length
    Layout.margins: 20
    signal headerClicked(idx: int)
    signal checkboxClicked(checked: bool, val: var )
    id: homeFormulaGrid
    property var headerList: []

    property var bodyList: []
    property int sortedColIdx: -1
    property int sortedColOrder: GridLayoutHeader.SortOrder.No
    property string  filterString: ""

    Repeater {
        model: headerList
        delegate: GridLayoutHeader {
            headerText: modelData
            sortOrder: sortedColIdx === index ? sortedColOrder : GridLayoutHeader.SortOrder.No
            onHeaderClicked: {
                homeFormulaGrid.headerClicked(index)
            }
        }
    }


    Repeater {
        model: bodyList
        delegate: RowLayout {
            Label {
                visible: !modelData.fillWidth && modelData.cellType === "text" &&
                          modelData.filterString.includes(filterString)
                text: modelData.cellText
                color : Constants.systemPalette.text
                ToolTip {
                        id: toolTip
                        contentItem: Text {
                            color: Constants.systemPalette.text

                            text: toolTip.text
                        }
                        background: Rectangle {
                            color: Constants.systemPalette.base
                        }
                    }

                MouseArea {
                    anchors.fill: parent
                    cursorShape: modelData.hoverText ? Qt.PointingHandCursor : cursorShape
                    hoverEnabled: true
                    onHoveredChanged: {
                        if (modelData.hoverText) {
                            toolTip.show(modelData.hoverText, 3000)
                        }
                    }
                }
            }
            Label {
                text: modelData.cellText
                visible: modelData.fillWidth &&
                         modelData.cellType === "text" &&
                         modelData.filterString.includes(filterString)
                color : Constants.systemPalette.text
                wrapMode: Text.WordWrap
                Layout.fillWidth: true
            }
            CheckBox {
                visible: modelData.cellType === "checkbox" &&
                         modelData.filterString.includes(filterString)
                text: modelData.cellText
                onClicked: ()=>{
                               homeFormulaGrid.checkboxClicked(checked, modelData.onToggled)
                           }
            }
            HyperlinkBtn {
                visible: modelData.cellType === "linkBtn" &&
                         modelData.filterString.includes(filterString)
                urlText: modelData.cellText
            }
        }
    }



}
