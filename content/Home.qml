import CakebrewJs2
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

ColumnLayout {
    visible: previewData.state === "Home"


    ExtendableHeader {
        id: caskHeader
        isExtended: true
        headerText: "Cask"
    }

    GridLayout {

        columns: 5
        visible: caskHeader.isExtended
        Layout.margins: 20


        Label {
            text: "<h4>Token</h4>"
            color : Constants.systemPalette.text
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
            text: "anaconda"
            color : Constants.systemPalette.text
        }
        Label {
            text: "Distribution of the Python and R programming languages for scientific computing"
            color : Constants.systemPalette.text
            wrapMode: Text.WordWrap
            Layout.fillWidth: true
        }
        Label {
            text: "homebrew/tap"
            color : Constants.systemPalette.text
        }
        Label {
            text: "auto update"
            color : Constants.systemPalette.text
        }

        Label {
            text: ""
            color : Constants.systemPalette.text
        }


    }
    ExtendableHeader {
        id: formulaHeader
        isExtended: true
        headerText: "Formula"
    }
    HomeGrid {
        visible: formulaHeader.isExtended
        onClicked: (idx)=>{
            if (sortedColIdx !== idx){
                sortedColOrder = GridLayoutHeader.SortOrder.No
            }

            sortedColIdx = idx;
            if (sortedColOrder === GridLayoutHeader.SortOrder.Asc){
                sortedColOrder = GridLayoutHeader.SortOrder.Dsc
            } else if (sortedColOrder === GridLayoutHeader.SortOrder.Dsc){
                sortedColOrder = GridLayoutHeader.SortOrder.No
            } else {
                sortedColOrder = GridLayoutHeader.SortOrder.Asc
            }
        }
        headerList: [
                "Name",
                "Desk",
                "Tap",
                "Version",
                "outdated",
                "Leaf"
            ]

        bodyList: [
               {cellType: "linkBtn", cellText: "libxext", fillWidth: false},
               {cellType: "text",
                   cellText: "X.Org: Library for common extensions to the X11 protocol",
                   fillWidth: true
               },
               {cellType: "text", cellText: "homebrew/tap", fillWidth: false},
               {cellType: "text", cellText: "1.3.5", fillWidth: false},
               {cellType: "checkbox", cellText: "1.3.6", fillWidth: false},
               {cellType: "text", cellText: ".", fillWidth: false},       
           ]

        sortedColIdx: 4
        sortedColOrder: GridLayoutHeader.SortOrder.Dsc
    }






    ExtendableHeader {
        id: servicesHeader
        isExtended: true
        headerText: "Services"
    }
    GridLayout {

        columns: 5
        visible: servicesHeader.isExtended
        Layout.margins: 20


        Label {
            text: "<h4>Name</h4>"
            color : Constants.systemPalette.text
        }
        Label {
            text: "<h4>Status</h4>"
            color : Constants.systemPalette.text
        }
        Label {
            text: "<h4>User</h4>"
            color : Constants.systemPalette.text
        }
        Label {
            text: "<h4>Plist</h4>"
            color : Constants.systemPalette.text
        }
        Label {
            text: "<h4>Actions</h4>"
            color : Constants.systemPalette.text
        }
        Label {
            text: "unbound"
            color : Constants.systemPalette.text
        }
        Label {
            text: "none"
            color : Constants.systemPalette.text
        }
        Label {
            text: ""
            color : Constants.systemPalette.text
        }
        Label {
            text: "/usr/local/opt/unbound/homebrew.mxcl.unbound.plist"
            color : Constants.systemPalette.text
            wrapMode: Text.WordWrap
            Layout.fillWidth: true
        }
        Label {
            text: ""
            color : Constants.systemPalette.text
        }
    }




}
