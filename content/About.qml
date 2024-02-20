import CakebrewJs2
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

RowLayout {
    ColumnLayout {
        Button {
            text: "Back"
            onClicked: stateGroup.state = "Preview"
        }

        Label {
            text: "<H1>About text</h1><p>shalom</p>"
        }
        Item {
            Layout.fillHeight: true
        }
    }
}
