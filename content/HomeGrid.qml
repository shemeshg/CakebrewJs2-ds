import CakebrewJs2
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Core

GridLayout {
    columns: headerList.length
    Layout.margins: 20
    rowSpacing: 10
    signal headerClicked(int idx)
    signal checkboxClicked(bool checked, var val)
    signal hyperlinkBtnClicked(string filterString, string cellText)

    id: homeGrid
    property var headerList: []

    property var bodyList: []
    property int sortedColIdx: -1
    property int sortedColOrder: GridLayoutHeader.SortOrder.No
    property string filterString: ""

    function bodylistFiltered(){
        return bodyList.filter(row=>{
                                   return row.filterString.toLowerCase().includes(filterString.toLowerCase())
                               })
    }

    Repeater {
        model: headerList
        delegate: GridLayoutHeader {
            headerText: modelData
            sortOrder: sortedColIdx === index ? sortedColOrder : GridLayoutHeader.SortOrder.No
            onHeaderClicked: {
                homeGrid.headerClicked(index)
            }
        }
    }

    Repeater {
        model: bodylistFiltered()
        delegate: RowLayout {
            CoreLabel {
                visible: !modelData.fillWidth && modelData.cellType === "text"
                text: modelData.cellText
                color: CoreSystemPalette.text
                CoreToolTip {
                    id: toolTip
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
            CoreLabel {
                text: modelData.cellText
                visible: modelData.fillWidth && modelData.cellType === "text"
                color: CoreSystemPalette.text
                wrapMode: Text.WordWrap
                Layout.fillWidth: true
            }
            CheckBox {
                visible: modelData.cellType === "checkbox"
                text: modelData.cellText
                onClicked: () => {
                               homeGrid.checkboxClicked(
                                   checked, modelData.onToggled)
                           }
            }
            HyperlinkBtn {
                visible: modelData.cellType === "linkBtn"
                urlText: modelData.cellText
                onLinkActivated: data => {
                                     var d = JSON.parse(data)
                                     homeGrid.hyperlinkBtnClicked(d[0],
                                                                         d[1])
                                 }
                urlRef: JSON.stringify(
                            [modelData.filterString, modelData.cellText])
            }
        }
    }
}
