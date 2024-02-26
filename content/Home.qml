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




        bodyList: Constants.brewData.caskBodyList

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

        bodyList: Constants.brewData.formulaBodyList

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

        bodyList: Constants.brewData.servicesBodyList

        sortedColIdx: 0
        sortedColOrder: GridLayoutHeader.SortOrder.Dsc
    }

}
