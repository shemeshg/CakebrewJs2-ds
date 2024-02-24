import CakebrewJs2
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

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
            Button {
                id: btnHomeId
                text: "Home"
                autoExclusive: true
                checkable: true
                checked: true
            }
            Button {
                id: btnInfoId
                text: "Info"
                autoExclusive: true
                checkable: true
            }
            Button {
                id: btnSearchId
                text: "Search"
                autoExclusive: true
                checkable: true
            }

            Button {
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
