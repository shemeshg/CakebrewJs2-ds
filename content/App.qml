// Copyright (C) 2021 The Qt Company Ltd.
// SPDX-License-Identifier: LicenseRef-Qt-Commercial OR GPL-3.0-only
import CakebrewJs2
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Window {
    width: 1000
    height: 800
    visible: true
    title: qsTr("Hello World")
    SystemPalette {
        id: systemPalette
    }
    color: systemPalette.window

    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 10

        PreviewData {
            visible: stateGroup.state === "Preview"
        }

        LoadingData {
            visible: stateGroup.state === "LoadingData"
        }

        Item {
            Layout.fillHeight: true
        }

        BottomBar {
            onRefreshClicked: {
                console.log("asdasdasd")
                if (stateGroup.state === "Preview") {
                    stateGroup.state = "LoadingData"
                } else {
                    stateGroup.state = "Preview"
                }
            }
        }
    }

    StateGroup {
        id: stateGroup
        state: "Preview"
        states: [
            State {
                name: "Preview"

                PropertyChanges {
                    target: rectangle
                    Layout.fillHeight: true
                    Layout.fillWidth: true
                }
            },
            State {
                name: "LoadingData"
            }
        ]
    }
}
