import CakebrewJs2
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

GridLayout {
    columns: 6
    Layout.margins: 20


    GridLayoutHeader {
        id: name
        headerText: "Name"
        onClicked: {
            if (name.sortOrder === GridLayoutHeader.SortOrder.Asc){
                name.sortOrder = GridLayoutHeader.SortOrder.Dsc
            } else if (sortOrder === GridLayoutHeader.SortOrder.Dsc){
                name.sortOrder = GridLayoutHeader.SortOrder.No
            } else {
                name.sortOrder = GridLayoutHeader.SortOrder.Asc
            }
        }
    }
    Label {
        text: "<h4>Desk</h4>"
        color : Constants.systemPalette.text
    }
    Label {
        text: "<h4>Tap</h4>"
        color : Constants.systemPalette.text
    }
    Label {
        text: "<h4>Version</h4>"
        color : Constants.systemPalette.text
    }
    Label {
        text: "<h4>outdated</h4>"
        color : Constants.systemPalette.text
    }
    Label {
        text: "<h4>Leaf</h4>"
        color : Constants.systemPalette.text
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
