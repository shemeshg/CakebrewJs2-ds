import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import core
import Qt.labs.qmlmodels

ColumnLayout {

    id: collapseableTableViewFormula    
    property int autoExtendCol: 1
    property int sortedColOrder: CollapseableTableViewFormula.SortOrder.Asc
    property int sortedColIdx: 2
    property string headerText: "Formula Table"
    property bool isExtended: true
    property var rowsModel: [
        {
            "name": {text: "Name"},
            "desc": {text: "Description"},
            "tap": {text: "Tap"},
            "version": {text: "Version"},
            "outdated": {text: "Outdated"},
            "leaf": {text: "Leaf"},
            "filterString": "" //header must filter empty
        },
        {
            "name": {text: "libext"},
            "desc": {text: "very asdfhaksdgflkagdsfasdlflhkg Description"},
            "tap": {text: "Tap"},
            "version": {text: "1.23"},
            "outdated": {text: "2.00", tsChecked: false},
            "leaf": {text: "*", hoverText: "shalom\nolam"},
            "filterString": "abc"
        },  {
            "name": {text: "libext"},
            "desc": {text: "very pioutyoiuyrt Description"},
            "tap": {text: "Tap"},
            "version": {text: "1.23"},
            "outdated": {text: "2.00", tsChecked: false},
            "leaf": {text: "*", hoverText: "shalom\nolam"},
            "filterString": "abc"
        },  {
            "name": {text: "libext"},
            "desc": {text: "very pioutyoiuyrt Description"},
            "tap": {text: "Tap"},
            "version": {text: "1.23"},
            "outdated": {text: "2.00", tsChecked: false},
            "leaf": {text: "*", hoverText: "shalom\nolam"},
            "filterString": "abc"
        },
        {
            "name": {text: "libext"},
            "desc": {text: "very pioutyoiuyrt Description"},
            "tap": {text: "Tap"},
            "version": {text: "1.23"},
            "outdated": {text: "2.00", tsChecked: false},
            "leaf": {text: "*", hoverText: "shalom\nolam"},
            "filterString": "abc"
        },
        {
            "name": {text: "libext"},
            "desc": {text: "very pioutyoiuyrt Description"},
            "tap": {text: "Tap"},
            "version": {text: "1.23"},
            "outdated": {text: "2.00", tsChecked: false},
            "leaf": {text: "*", hoverText: "shalom\nolam"},
            "filterString": "abc"
        }]


    Layout.fillWidth: true

    signal headerClicked(int column)



    enum SortOrder {
           No,
           Asc,
           Dsc
     }

    function getRowsModel(){
        return rowsModel.filter((row)=>{
                                return row.filterString.toLowerCase().includes(filterByExp.text.toLowerCase()) ||
                                    row.filterString === ""
                                });
    }

    function getOrderSymble(col){
        if (col === sortedColIdx){
            if (sortedColOrder === CollapseableTableViewFormula.SortOrder.Asc){
                return " ↑"
            } else if (sortedColOrder === CollapseableTableViewFormula.SortOrder.Dsc){
                return " ↓"
            } else {
                return ""
            }
        }

        return ""
    }

    ExtendableHeader {
        id: formulaHeader
        isExtended: collapseableTableViewFormula.isExtended
        headerText: collapseableTableViewFormula.headerText
    }

    CoreTextField {
        id: filterByExp
        visible: formulaHeader.isExtended
        text: ""
        Layout.fillWidth: true
        Layout.rightMargin:  5
        placeholderText: "Filter"
        onTextChanged: {
            tableView.filteredModel = []
            tableView.filteredModel = getRowsModel()
            tableView.visible = false
            tableView.forceLayout()

            filterSetTimer.start()
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


    TableView {
        property var filteredModel: rowsModel
        property var calWids: []//[0,0,0,0,0,0]

        Layout.fillWidth: true
        visible: formulaHeader.isExtended
        implicitHeight: contentHeight
        columnSpacing: 1
        rowSpacing: 1
        clip: true
        id: tableView


        onWidthChanged: tableView.forceLayout()
        columnWidthProvider: function (column) {
            tableView.calWids[column] = implicitColumnWidth(column)
            let total=0
            if (column === autoExtendCol){
                for (let i=0;i<tableView.calWids.length;i++){
                    if (i!==autoExtendCol){
                        if (tableView.calWids[i] <=0){
                            return implicitColumnWidth(column)
                        }

                        total = total + tableView.calWids[i]
                    }
                }
                return tableView.width - total - 30
            }
            return implicitColumnWidth(column)
        }

        ScrollBar.vertical: ScrollBar {
            policy: ScrollBar.AsNeeded
        }

        model: TableModel {

            TableModelColumn {
                display: "name"
            }
            TableModelColumn {
                display: "desc"
            }
            TableModelColumn {
                display: "tap"
            }
            TableModelColumn {
                display: "version"
            }
            TableModelColumn {
                display: "outdated"
            }
            TableModelColumn {
                display: "leaf"
            }

            // Each row is one type of fruit that can be ordered
            rows: tableView.filteredModel

        }
        delegate: DelegateChooser {
            DelegateChoice {
                index:0
                CoreLabel {
                    text:  "<h4>" +  model.display.text + getOrderSymble(column)  + "</h4>"
                    leftPadding: 10
                    rightPadding: 10
                    MouseArea {
                        anchors.fill: parent
                        cursorShape: Qt.PointingHandCursor
                        onClicked: ()=>{
                                       collapseableTableViewFormula.headerClicked(column)
                                   }
                    }
                }
            }

            DelegateChoice {
                column: 0
                delegate: HyperlinkBtn {
                    leftPadding: 10
                    urlText: model.display.text
                    onLinkActivated: data => {
                                        console.log(data)
                                     }
                    urlRef: model.display.text
                }
            }

            DelegateChoice {
                column: 4
                delegate: CheckBox {
                    checked: model.display.tsChecked
                    leftPadding: 10
                    text: model.display.text
                    onToggled: model.display.tsChecked = checked
                }
            }


            DelegateChoice {
                column: 5
                delegate: CoreLabel {
                    leftPadding: 10
                    text: model.display.text
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
                                toolTip.show(model.display.hoverText, 3000)
                            }
                        }
                    }
                }
            }

            DelegateChoice {
                column: collapseableTableViewFormula.autoExtendCol
                CoreLabel {
                    text: model.display.text
                    wrapMode: Text.WordWrap
                    leftPadding: 10
                }
            }
            DelegateChoice {
                CoreLabel {
                    text: model.display.text
                    leftPadding: 10
                }
            }
        }
    }
}
