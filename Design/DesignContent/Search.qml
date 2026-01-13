import Design
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Core

ColumnLayout {
    Layout.leftMargin: 10
    Layout.rightMargin: 20

    function textsearchWithoutRubyRegex(){
        let a = textSearch.text;
        // remove leading slashes
        a = a.replace(/^\/+/, "");
        // remove trailing slash
        a = a.replace(/\/+$/, "");
        // remove trailing "$" if it exists
        return a.replace(/\$$/, "");
    }

    function filtredSearchedFormulaItems() {
        let a = textsearchWithoutRubyRegex()
        return Constants.brewData.searchItemsFormula.filter(r => {


                                                                 const searchRegExp = new RegExp(a.replace(/^\/+|\/+$/g, ""),"i");
                                                                return searchRegExp.test(r.name + r.token + r.version + r.homepage + r.desc);
                                                            })
    }

    function filtredSearchedCaskItems() {
        let a = textsearchWithoutRubyRegex()
        return Constants.brewData.searchItemsCask.filter(r => {
                                                            const searchRegExp = new RegExp(a.replace(/^\/+|\/+$/g, ""),"i");
                                                             return searchRegExp.test(r.name + r.token + r.version + r.homepage + r.desc)
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
                    textSearch.text = textSearch.text.trim().replace(/\s+/g, ' ');
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
                isLoading: Constants.brewData.searchCaskRunning
            }

            CoreLabel {
                text: Constants.brewData.searchStatusCaskText
                visible: Constants.brewData.searchStatusCaskVisible
                         && !Constants.brewData.searchCaskRunning
                        && caskHeader.isExtended
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
            isLoading: Constants.brewData.searchFormulaRunning
        }
        CoreLabel {
            text: Constants.brewData.searchStatusFormulaText
            visible: Constants.brewData.searchStatusFormulaVisible
                     && !Constants.brewData.searchFormulaRunning
                    && formulaHeader.isExtended
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
