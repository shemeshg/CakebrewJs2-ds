import CakebrewJs2
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Core

ColumnLayout {
    Layout.margins: 10
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

    property bool searchEnabled: {
        return !Constants.brewData.searchCaskRunning
                && !Constants.brewData.searchFormulaRunning
                && textSearch.text.trim() !== ""
    }

    function doSearchAction() {
        Constants.brewData.asyncSearch(() => {}, textSearch.text, true)
        Constants.brewData.asyncSearch(() => {}, textSearch.text, false)
    }

    onVisibleChanged: {
        if (visible) {
            textSearch.forceActiveFocus()
        }
    }

    RowLayout {
        CoreTextField {
            id: textSearch
            placeholderText: "Regex example /^r/"
            Layout.fillWidth: true
            onAccepted: {
                if (searchEnabled) {
                    doSearchAction()
                }
            }
        }
        CoreButton {
            text: "Search"
            enabled: searchEnabled
            onClicked: {
                doSearchAction()
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
                        isCask: true
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
                    isCask: false
                }
            }
        }
    }
}
