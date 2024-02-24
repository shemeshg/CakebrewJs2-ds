import CakebrewJs2
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

ColumnLayout {


    CollapseableGrid {
        property var selectedItems: []
        onCheckboxClicked: (c,v)=>{
                               if (c){
                                   selectedItems.push(v)
                                   selectedItems = [...selectedItems];
                               } else {
                                   selectedItems.splice(selectedItems.indexOf(v), 1);
                                   selectedItems = [...selectedItems];
                               }
                           }
         headerText: "Cask (" + selectedItems.length + ")"

        isExtended: true


        headerList: [
            "Token",
            "Desk",
            "Tap",
            "Version",
            "outdated",
        ]




        bodyList: [
            {cellType: "linkBtn", cellText: "anaconda", fillWidth: false},
            {cellType: "text",
                cellText: "Distribution of the Python and R programming languages for scientific computing",
                fillWidth: true
            },
            {cellType: "text", cellText: "homebrew/tap", fillWidth: false},
            {cellType: "text", cellText: "1.3.5", fillWidth: false},
            {cellType: "checkbox", cellText: "1.3.6", fillWidth: false, onToggled: "anaconda"},
        ]

        sortedColIdx: 4
        sortedColOrder: GridLayoutHeader.SortOrder.Dsc
    }

    CollapseableGrid {
        property var selectedItems: []
        onCheckboxClicked: (c,v)=>{
                               if (c){
                                   selectedItems.push(v)
                                   selectedItems = [...selectedItems];
                               } else {
                                   selectedItems.splice(selectedItems.indexOf(v), 1);
                                   selectedItems = [...selectedItems];
                               }
                           }
         headerText: "Formula (" + selectedItems.length + ")"

        isExtended: true

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
            {cellType: "checkbox", cellText: "1.3.6", fillWidth: false,onToggled: "linkBtn" },
            {cellType: "text", cellText: ".", fillWidth: false,
                hoverText: "<h3>Used in</h3><p>item 1</p><h3>Used by</h3><p>item 2</p>"},
        ]

        sortedColIdx: 4
        sortedColOrder: GridLayoutHeader.SortOrder.Dsc
    }



    CollapseableGrid {
        isExtended: true
        headerText: "Services"

        headerList: [
            "Name",
            "Status",
            "User",
            "Plist",
            "Actions",
        ]

        bodyList: [
            {cellType: "text", cellText: "unbound", fillWidth: false},
            {cellType: "text", cellText: "none", fillWidth: false},
            {cellType: "text", cellText: "", fillWidth: false},
            {cellType: "text",
                cellText: "/usr/local/opt/unbound/homebrew.mxcl.unbound.plist",
                fillWidth: true
            },
            {cellType: "linkBtn", cellText: "stop", fillWidth: false},
        ]

        sortedColIdx: 0
        sortedColOrder: GridLayoutHeader.SortOrder.Dsc
    }

}
