import CakebrewJs2
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

GroupBox {
    id: bottomBarId
    Layout.fillWidth: true
    signal refreshClicked
    signal aboutClicked
    RowLayout {
        anchors.left: parent.left
        anchors.right: parent.right

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
        Item {
            Layout.fillWidth: true
        }
        Button {
            text: "://brew.sh"
        }
        Button {
            text: "About"
            onClicked: {
                aboutClicked()
            }
        }
    }
}
