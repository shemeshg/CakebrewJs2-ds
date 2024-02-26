import CakebrewJs2
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

GroupBox {
    id: bottomBarId
    Layout.fillWidth: true
    signal refreshClicked
    signal aboutClicked
    signal backClicked
    property string selectedPreview: ""

    readonly property int upgradableItems: {
        return Constants.brewData.formulaBodyList.filter(row => {
                                                             return row.cellType === "checkbox"
                                                         }).length
                + Constants.brewData.caskBodyList.filter(row => {
                                                             return row.cellType === "checkbox"
                                                         }).length
    }

    RowLayout {
        anchors.left: parent.left
        anchors.right: parent.right

        RowLayout {
            visible: selectedPreview === "Home"
            Button {
                text: "Refresh (" + Constants.brewData.lastUpdateDateStr + ")"
                onClicked: {
                    refreshClicked()
                }
            }
            Button {
                text: "Upgrade all (" + upgradableItems + ")"
            }
            Button {
                text: "Upgrade selected (" + Number(
                          Constants.selectedFormulaItems.length
                          + Constants.selectedCaskItems.length) + ")"
            }
            Button {
                text: "Doctor"
            }
        }
        RowLayout {
            visible: selectedPreview === "Info-cask"
            Button {
                text: "Uninstall"
            }
            Button {
                text: "Uninstall zap"
            }
        }

        Item {
            Layout.fillWidth: true
        }
        Button {
            visible: selectedPreview === "back"
            text: "Back"
            onClicked: {
                backClicked()
            }
        }
        Button {
            visible: selectedPreview !== "back"
            text: "://brew.sh"
        }
        Button {
            visible: selectedPreview !== "back"
            text: "About"
            onClicked: {
                aboutClicked()
            }
        }
    }
}
