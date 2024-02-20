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
    RowLayout {
        anchors.left: parent.left
        anchors.right: parent.right

        RowLayout {
            visible: selectedPreview === "Home"
            Button {
                text: "Refresh"
                onClicked: {
                    refreshClicked()
                }
            }
            Button {
                text: "Upgrade all (1)"
            }
            Button {
                text: "Upgrade selected (0)"
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
