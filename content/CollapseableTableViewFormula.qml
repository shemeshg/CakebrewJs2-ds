import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import core
import Qt.labs.qmlmodels

ColumnLayout {
    Layout.fillWidth: true

    CoreLabel {
        text: "Table will be here"
    }

    TableView {
        Layout.fillWidth: true

        implicitHeight: contentHeight
        columnSpacing: 1
        rowSpacing: 1
        clip: true
        id: tableView

        property var calWids: [0,0,0,0,0,0]
        property int autoExtendCol: 1

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
                    "name"// Each property is one cell/column.
                    : "Name",
                    "desc": "Description",
                    "tap": "Tap",
                    "version": "Version",
                    "outdated": "Outdated",
                    "leaf": "Leaf"

                },
                {
                    "name"// Each property is one cell/column.
                    : "libext",
                    "desc": "very asdfhaksdgflkagdsfasdlflhkg Description",
                    "tap": "Tap",
                    "version": "1.23",
                    "outdated": "2.00",
                    "leaf": "*"
                },  {
                    "name"// Each property is one cell/column.
                    : "asdf",
                    "desc": "very pioutyoiuyrt Description",
                    "tap": "Tap",
                    "version": "1.23",
                    "outdated": "2.00",
                    "leaf": "*"
                },  {
                    "name"// Each property is one cell/column.
                    : "asdf",
                    "desc": "very pioutyoiuyrt Description",
                    "tap": "Tap",
                    "version": "1.23",
                    "outdated": "2.00",
                    "leaf": "*"
                },
                {
                    "name"// Each property is one cell/column.
                    : "asdf",
                    "desc": "very pioutyoiuyrt Description",
                    "tap": "Tap",
                    "version": "1.23",
                    "outdated": "2.00",
                    "leaf": "*"
                },
                {
                    "name"// Each property is one cell/column.
                    : "asdf",
                    "desc": "very pioutyoiuyrt Description",
                    "tap": "Tap",
                    "version": "1.23",
                    "outdated": "2.00",
                    "leaf": "*"
                }]
        }
        delegate: DelegateChooser {
            DelegateChoice {
                index:0
                CoreLabel {
                    text: model.display
                    leftPadding: 10
                }
            }

            DelegateChoice {
                column: 4
                delegate: CheckBox {
                    checked: model.display
                    leftPadding: 10
                    //onToggled: model.display = checked
                }
            }

            DelegateChoice {
                column: tableView.autoExtendCol
                CoreLabel {
                    text: model.display
                    wrapMode: Text.WordWrap
                    leftPadding: 10
                }
            }
            DelegateChoice {
                CoreLabel {
                    text: model.display
                    leftPadding: 10
                }
            }
        }
    }
    CoreLabel {
        text: "<h1>we have more</h1>"
    }
}
