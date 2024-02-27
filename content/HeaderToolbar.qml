import CakebrewJs2
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Core

RowLayout {
    property alias btnHomeId: btnHomeId
    property alias btnInfoId: btnInfoId
    property alias btnSearchId: btnSearchId
    property alias btnSettingsId: btnSettingsId
    Item {
        Layout.fillWidth: true
    }

    GroupBox {

        RowLayout {
            CoreButton {
                id: btnHomeId
                text: "Home"
                autoExclusive: true
                checkable: true
                checked: true
            }
            CoreButton {
                id: btnInfoId
                text: "Info"
                autoExclusive: true
                checkable: true
            }
            CoreButton {
                id: btnSearchId
                text: "Search"
                autoExclusive: true
                checkable: true
            }

            CoreButton {
                id: btnSettingsId
                text: "Settings"
                autoExclusive: true
                checkable: true
            }
        }
    }

    Item {
        Layout.fillWidth: true
    }

}
