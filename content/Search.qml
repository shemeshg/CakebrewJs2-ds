import CakebrewJs2
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Core

ColumnLayout {


    RowLayout {
        CoreTextField {
            id: textSearch
            placeholderText: "Regex example /^r/"
            Layout.fillWidth: true
        }
        CoreButton {
            text: "Search"
            enabled: !Constants.brewData.searchCaskRunning && !Constants.brewData.searchFormulaRunning
            onClicked: {
                Constants.brewData.asyncSearch(() => {
                                                        //caskModel = ["a", "b"]
                                                    },
                                               textSearch.text,
                                               true)
                Constants.brewData.asyncSearch(() => {
                                                        //formullaModel = ["c", "d"]
                                                    },
                                               textSearch.text,
                                               false)


            }
        }
    }
    RowLayout {

        ColumnLayout {

            CoreLabel {
                text: Constants.brewData.searchStatusCaskText
                visible: Constants.brewData.searchStatusCaskVisible
            }

            ExtendableHeader {
                id: caskHeader
                isExtended: true
                headerText: "Cask"
                visible: !Constants.brewData.searchCaskRunning
            }
            ColumnLayout {
                visible: caskHeader.isExtended && Constants.brewData.searchItemsCask.length > 0
                         && !Constants.brewData.searchCaskRunning
                Repeater {
                    model: Constants.brewData.searchItemsCask
                    delegate: SearchListItem {
                        itemName: modelData.name
                        itemTag: modelData.token
                        itemVer: modelData.version
                        itemIsInstalled: modelData.installed
                        itemUrl: modelData.homepage
                        itemDesk: modelData.desc
                    }
                }
            }
        }
    }

    ColumnLayout {
        CoreLabel {
            text: Constants.brewData.searchStatusFormulaText
            visible: Constants.brewData.searchStatusFormulaVisible
        }
        ExtendableHeader {
            id: formulaHeader
            isExtended: true
            headerText: "Formula"
            visible: !Constants.brewData.searchFormulaRunning
        }
        ColumnLayout {
            visible: formulaHeader.isExtended && Constants.brewData.searchItemsFormula.length > 0
                     && !Constants.brewData.searchFormulaRunning
            Repeater {
                model: Constants.brewData.searchItemsFormula
                delegate: SearchListItem {
                    itemName: modelData.name
                    itemTag: modelData.token
                    itemVer: modelData.version
                    itemIsInstalled: modelData.installed
                    itemUrl: modelData.homepage
                    itemDesk: modelData.desc
                }
            }
        }
    }
}
