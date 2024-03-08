import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import core
import Qt.labs.qmlmodels

ColumnLayout {

    id: collapseableTableViewFormula
    property var calWids: [0,0,0,0,0,0]
    property int autoExtendCol: 1
    property int sortedColOrder: CollapseableTableViewFormula.SortOrder.Asc
    property int sortedColIdx: 2

    Layout.fillWidth: true

    signal headerClicked(int column)


    CoreLabel {
        text: "Table will be here"
    }

    enum SortOrder {
           No,
           Asc,
           Dsc
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

    TableView {
        Layout.fillWidth: true

        implicitHeight: contentHeight
        columnSpacing: 1
        rowSpacing: 1
        clip: true
        id: tableView



        columnWidthProvider: function (column) {
            calWids[column] = implicitColumnWidth(column)
            let total=0
            if (column === autoExtendCol){
                for (let i=0;i<calWids.length;i++){
                    if (i!==autoExtendCol){
                        if (calWids[i] <=0){
                            return implicitColumnWidth(column)
                        }

                        total = total + calWids[i]
                    }
                }
                return tableView.width - total - 30
            }
            return implicitColumnWidth(column)
        }

        onWidthChanged: tableView.forceLayout()

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
            rows: [
                {
                    "name": {text: "Name"},
                    "desc": {text: "Description"},
                    "tap": {text: "Tap"},
                    "version": {text: "Version"},
                    "outdated": {text: "Outdated"},
                    "leaf": {text: "Leaf"},
                },
                {
                    "name": {text: "libext"},
                    "desc": {text: "very asdfhaksdgflkagdsfasdlflhkg Description"},
                    "tap": {text: "Tap"},
                    "version": {text: "1.23"},
                    "outdated": {text: "2.00", tsChecked: false},
                    "leaf": {text: "*", hoverText: "shalom\nolam"}
                },  {
                    "name": {text: "libext"},
                    "desc": {text: "very pioutyoiuyrt Description"},
                    "tap": {text: "Tap"},
                    "version": {text: "1.23"},
                    "outdated": {text: "2.00", tsChecked: false},
                    "leaf": {text: "*", hoverText: "shalom\nolam"}
                },  {
                    "name": {text: "libext"},
                    "desc": {text: "very pioutyoiuyrt Description"},
                    "tap": {text: "Tap"},
                    "version": {text: "1.23"},
                    "outdated": {text: "2.00", tsChecked: false},
                    "leaf": {text: "*", hoverText: "shalom\nolam"}
                },
                {
                    "name": {text: "libext"},
                    "desc": {text: "very pioutyoiuyrt Description"},
                    "tap": {text: "Tap"},
                    "version": {text: "1.23"},
                    "outdated": {text: "2.00", tsChecked: false},
                    "leaf": {text: "*", hoverText: "shalom\nolam"}
                },
                {
                    "name": {text: "libext"},
                    "desc": {text: "very pioutyoiuyrt Description"},
                    "tap": {text: "Tap"},
                    "version": {text: "1.23"},
                    "outdated": {text: "2.00", tsChecked: false},
                    "leaf": {text: "*", hoverText: "shalom\nolam"}
                }]
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
    CoreLabel {
        text: "<h1>we have more</h1>"
    }
}
