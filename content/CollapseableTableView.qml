import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Core
import Qt.labs.qmlmodels

ColumnLayout {
    Layout.margins: 20


    id: collapseableTableView
    property int autoExtendCol: 1
    property int sortedColOrder: CollapseableTableView.SortOrder.Asc
    property int sortedColIdx: 4
    property string headerText: ""
    property bool isExtended: true
    property var rowsModel: []
    property alias tableView: tableView
    property var filteredModel: rowsModel

    Layout.fillWidth: true

    enum SortOrder {
        No,
        Asc,
        Dsc
    }

    function getRowsModel() {
        return rowsModel.filter(row => {
                                    return row.filterString.toLowerCase(
                                        ).includes(
                                        filterByExp.text.toLowerCase())
                                    || row.filterString === ""
                                })
    }

    function filterTableByFilter(){
        filteredModel = []
        filteredModel = getRowsModel()
        tableView.visible = false
        tableView.forceLayout()

        filterSetTimer.start()
    }

    ExtendableHeader {
        id: formulaHeader
        isExtended: collapseableTableView.isExtended
        headerText: collapseableTableView.headerText
    }

    CoreTextField {
        id: filterByExp
        visible: formulaHeader.isExtended
        text: ""
        Layout.fillWidth: true
        Layout.rightMargin: 5
        placeholderText: "Filter"
        onTextChanged: {
            filterTableByFilter()
        }
        Timer {
            id: filterSetTimer
            running: true
            repeat: false
            onTriggered: {
                tableView.forceLayout()
                tableView.height = tableView.contentHeight
                tableView.visible = true
            }

            interval: 0
        }
    }

    ColumnLayout {
        visible: formulaHeader.isExtended

        TableView {
            property var calWids: [] //[0,0,0,0,0,0]            
            Layout.fillWidth: true
            implicitHeight: contentHeight
            columnSpacing: 10
            rowSpacing: 10
            clip: true
            id: tableView

            onWidthChanged: tableView.forceLayout()
            columnWidthProvider: function (column) {
                tableView.calWids[column] = implicitColumnWidth(column)
                let total = 0
                if (column === autoExtendCol) {
                    for (var i = 0; i < tableView.calWids.length; i++) {
                        if (i !== autoExtendCol) {
                            if (tableView.calWids[i] <= 0) {
                                return implicitColumnWidth(column)
                            }

                            total = total + tableView.calWids[i]
                        }
                    }
                    return tableView.width - total - 50
                }
                return implicitColumnWidth(column)
            }

            ScrollBar.vertical: ScrollBar {
                policy: ScrollBar.AsNeeded
            }
        }
    }
}
