import CakebrewJs2
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Core

ColumnLayout {
    function filtredSearchedFormulaItems() {
        return Constants.brewData.searchItemsFormula.filter(r => {

                                                                return (r.name + r.token + r.version + r.homepage + r.desc).toLowerCase(
                                                                    ).includes(
                                                                    textSearch.text.toLowerCase(
                                                                        ))
                                                            })
    }

    function filtredSearchedCaskItems() {
        return Constants.brewData.searchItemsCask.filter(r => {

                                                             return (r.name + r.token + r.version + r.homepage + r.desc).toLowerCase(
                                                                 ).includes(
                                                                 textSearch.text.toLowerCase(
                                                                     ))
                                                         })
    }
    RowLayout {
        CoreTextField {
            id: textSearch
            placeholderText: "Regex example /^r/"
            Layout.fillWidth: true
        }
        CoreButton {
            text: "Search"
            enabled: !Constants.brewData.searchCaskRunning
                     && !Constants.brewData.searchFormulaRunning
                     && textSearch.text.trim() !== ""
            onClicked: {
                Constants.brewData.asyncSearch(() => {//caskModel = ["a", "b"]
                                               }, textSearch.text, true)
                Constants.brewData.asyncSearch(
                            () => {//formullaModel = ["c", "d"]
                            }, textSearch.text, false)
            }
        }
    }
    RowLayout {

        ColumnLayout {
            ExtendableHeader {
                id: caskHeader
                isExtended: true
                headerText: "Cask"
                visible: !Constants.brewData.searchCaskRunning
            }

            CoreLabel {
                text: Constants.brewData.searchStatusCaskText
                visible: Constants.brewData.searchStatusCaskVisible
            }
            ColumnLayout {
                visible: caskHeader.isExtended && filtredSearchedCaskItems(
                             ).length > 0
                         && !Constants.brewData.searchCaskRunning
                Repeater {
                    model: filtredSearchedCaskItems()
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
        ExtendableHeader {
            id: formulaHeader
            isExtended: true
            headerText: "Formula"
            visible: !Constants.brewData.searchFormulaRunning
        }
        CoreLabel {
            text: Constants.brewData.searchStatusFormulaText
            visible: Constants.brewData.searchStatusFormulaVisible
        }
        ColumnLayout {

            visible: formulaHeader.isExtended && filtredSearchedFormulaItems(
                         ).length > 0
                     && !Constants.brewData.searchFormulaRunning

            Repeater {
                id: formulaRepeater
                model: filtredSearchedFormulaItems()
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
