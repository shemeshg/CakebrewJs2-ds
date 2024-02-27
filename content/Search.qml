import CakebrewJs2
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Core

ColumnLayout {
    property var caskModel: []
    property var formullaModel: []

    RowLayout {
        CoreTextField {
            placeholderText: "Regex example /^r/"
            Layout.fillWidth: true
        }
        CoreButton {
            text: "Search"
            onClicked: {
                caskModel = ["a", "b"]
                formullaModel = ["c", "d"]
            }
        }
    }
    RowLayout {

        ColumnLayout {

            ExtendableHeader {
                id: caskHeader
                isExtended: true
                headerText: "Cask"
            }
            ColumnLayout {
                visible: caskHeader.isExtended && caskModel.length > 0
                Repeater {
                    model: caskModel
                    delegate: SearchListItem {
                        itemName: modelData
                        itemTag: "Cakebrewjs"
                        itemVer: "2.0.0"
                        itemIsInstalled: true
                        itemUrl: "https://google.com"
                        itemDesk: "Do things"
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
        }
        ColumnLayout {
            visible: formulaHeader.isExtended && formullaModel.length > 0
            Repeater {
                model: formullaModel
                delegate: SearchListItem {
                    itemName: modelData
                    itemTag: "Cakebrewjs"
                    itemVer: "2.0.0"
                    itemIsInstalled: true
                    itemUrl: "https://google.com"
                    itemDesk: "Do things"
                }
            }
        }
    }
}
