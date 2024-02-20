import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts

ColumnLayout {
    property bool isError: false

    Rectangle {
        Layout.fillWidth: true
        Layout.preferredHeight: 5
        color: isError ? "Dark red" : Constants.systemPalette.alternateBase
    }

    RowLayout {
        Label {
            text: "Runing: shalom\nolam"
            color: Constants.systemPalette.text
        }
    }
    Item {
        Layout.fillHeight: true
    }
}
