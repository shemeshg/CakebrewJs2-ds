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

    property int sortedColIdx: -1
    property int sortedColOrder: GridLayoutHeader.SortOrder.No

    Repeater {
        model: headerList
        delegate: GridLayoutHeader {
            id: name
            headerText: modelData
            sortOrder: sortedColIdx === index ? sortedColOrder : GridLayoutHeader.SortOrder.No
            onClicked: {
                homeFormulaGrid.clicked(index)
            }
        }
    }


    Label {
        text: "libxext"
        color : Constants.systemPalette.text
    }
    Label {
        text: "X.Org: Library for common extensions to the X11 protocol"
        color : Constants.systemPalette.text
        wrapMode: Text.WordWrap
        Layout.fillWidth: true
    }
    Label {
        text: "homebrew/tap"
        color : Constants.systemPalette.text
    }
    Label {
        text: "1.3.5"
        color : Constants.systemPalette.text
    }
    Label {
        text: "1.3.6"
        color : Constants.systemPalette.text
    }
    Label {
        text: "."
        color : Constants.systemPalette.text
    }

}
