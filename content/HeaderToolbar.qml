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
            Shortcut {
                 sequence: "Ctrl+M"
                 onActivated: {
                     btnHomeId.checked = true
                 }
             }
            Shortcut {
                 sequence: "Ctrl+I"
                 onActivated: {
                     btnInfoId.checked = true
                 }
             }
            Shortcut {
                 sequence: "Ctrl+F"
                 onActivated: {
                     btnSearchId.checked = true
                 }
             }
            Shortcut {
                 sequence: "Ctrl+,"
                 onActivated: {
                     btnSettingsId.checked = true
                 }
             }
            CoreButton {
                id: btnHomeId
                icon.source: Qt.resolvedUrl("images/home_FILL0_wght400_GRAD0_opsz24.svg")
                hooverText: "<b>⌘M</b> Home."
                autoExclusive: true
                checkable: true
                checked: true
            }
            CoreButton {
                id: btnInfoId
                icon.source: Qt.resolvedUrl("images/info_FILL0_wght400_GRAD0_opsz24.svg")
                hooverText: "<b>⌘I</b> Info."
                autoExclusive: true
                checkable: true

            }
            CoreButton {

                id: btnSearchId
                icon.source: Qt.resolvedUrl("images/search_FILL0_wght400_GRAD0_opsz24.svg")
                hooverText: "<b>⌘F</b> Find."
                autoExclusive: true
                checkable: true
            }

            CoreButton {                
                id: btnSettingsId
                icon.source: Qt.resolvedUrl("images/settings_FILL0_wght400_GRAD0_opsz24.svg")
                hooverText: "<b>⌘,</b> Settings."
                autoExclusive: true
                checkable: true
            }
        }
    }

    Item {
        Layout.fillWidth: true
    }

}
