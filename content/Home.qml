import CakebrewJs2
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

ColumnLayout {
    visible: previewData.state === "Home"


    ExtendableHeader {
        id: caskHeader
        isExtended: true
        headerText: "Cask"
    }

    GridLayout {

        columns: 5
        visible: caskHeader.isExtended
        Layout.margins: 20


        Label {
            text: "<h4>Token</h4>"
            color : Constants.systemPalette.text
        }
        Label {
            text: "<h4>Desk</h4>"
            color : Constants.systemPalette.text
        }
        Label {
            text: "<h4>Tap</h4>"
            color : Constants.systemPalette.text
        }
        Label {
            text: "<h4>Version</h4>"
            color : Constants.systemPalette.text
        }
        Label {
            text: "<h4>outdated</h4>"
            color : Constants.systemPalette.text
        }
        Label {
            text: "anaconda"
            color : Constants.systemPalette.text
        }
        Label {
            text: "Distribution of the Python and R programming languages for scientific computing"
            color : Constants.systemPalette.text
            wrapMode: Text.WordWrap
            Layout.fillWidth: true
        }
        Label {
            text: "homebrew/tap"
            color : Constants.systemPalette.text
        }
        Label {
            text: "auto update"
            color : Constants.systemPalette.text
        }

        Label {
            text: ""
            color : Constants.systemPalette.text
        }


    }
    ExtendableHeader {
        id: formulaHeader
        isExtended: true
        headerText: "Formula"
    }
    GridLayout {

        columns: 6
        visible: formulaHeader.isExtended
        Layout.margins: 20


        Label {
            text: "<h4>Name</h4>"
            color : Constants.systemPalette.text
        }
        Label {
            text: "<h4>Desk</h4>"
            color : Constants.systemPalette.text
        }
        Label {
            text: "<h4>Tap</h4>"
            color : Constants.systemPalette.text
        }
        Label {
            text: "<h4>Version</h4>"
            color : Constants.systemPalette.text
        }
        Label {
            text: "<h4>outdated</h4>"
            color : Constants.systemPalette.text
        }
        Label {
            text: "<h4>Leaf</h4>"
            color : Constants.systemPalette.text
        }
        Label {
            text: "libxext"
            color : Constants.systemPalette.text
        }
        Label {
            text: "X.Org: Library for common extensions to the X11 protocol"
            color : Constants.systemPalette.text
            wrapMode: Text.WordWrap
            Layout.fillWidth: true
        }
        Label {
            text: "homebrew/tap"
            color : Constants.systemPalette.text
        }
        Label {
            text: "1.3.5"
            color : Constants.systemPalette.text
        }
        Label {
            text: "1.3.6"
            color : Constants.systemPalette.text
        }
        Label {
            text: "."
            color : Constants.systemPalette.text
        }

    }






    ExtendableHeader {
        id: servicesHeader
        isExtended: true
        headerText: "Services"
    }
    GridLayout {

        columns: 5
        visible: servicesHeader.isExtended
        Layout.margins: 20


        Label {
            text: "<h4>Name</h4>"
            color : Constants.systemPalette.text
        }
        Label {
            text: "<h4>Status</h4>"
            color : Constants.systemPalette.text
        }
        Label {
            text: "<h4>User</h4>"
            color : Constants.systemPalette.text
        }
        Label {
            text: "<h4>Plist</h4>"
            color : Constants.systemPalette.text
        }
        Label {
            text: "<h4>Actions</h4>"
            color : Constants.systemPalette.text
        }
        Label {
            text: "unbound"
            color : Constants.systemPalette.text
        }
        Label {
            text: "none"
            color : Constants.systemPalette.text
        }
        Label {
            text: ""
            color : Constants.systemPalette.text
        }
        Label {
            text: "/usr/local/opt/unbound/homebrew.mxcl.unbound.plist"
            color : Constants.systemPalette.text
            wrapMode: Text.WordWrap
            Layout.fillWidth: true
        }
        Label {
            text: ""
            color : Constants.systemPalette.text
        }
    }




}
