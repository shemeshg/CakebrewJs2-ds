import CakebrewJs2
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

ColumnLayout {


    CollapseableGrid {

        onCheckboxClicked: (c,v)=>{
                               if (c){
                                   Constants.selectedCaskItems.push(v)
                                   Constants.selectedCaskItems = [...Constants.selectedCaskItems];
                               } else {
                                   Constants.selectedCaskItems.splice(Constants.selectedCaskItems.indexOf(v), 1);
                                   Constants.selectedCaskItems = [...Constants.selectedCaskItems];
                               }
                           }
         headerText: "Cask (" + Constants.selectedCaskItems.length + ")"

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

        onCheckboxClicked: (c,v)=>{
                               if (c){
                                   Constants.selectedFormulaItems.push(v)
                                   Constants.selectedFormulaItems = [...Constants.selectedFormulaItems];
                               } else {
                                   Constants.selectedFormulaItems.splice(Constants.selectedFormulaItems.indexOf(v), 1);
                                   Constants.selectedFormulaItems = [...Constants.selectedFormulaItems];
                               }
                           }
         headerText: "Formula (" + Constants.selectedFormulaItems.length + ")"

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
