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

    Component.onCompleted: {
        if (Constants.isDesigner) {
            Constants.setDesignerParams(stateGroup)
        }
    }

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

        RowLayout {
            id: aboutId
            visible: stateGroup.state === "About"
            ColumnLayout {
                Button {
                    text: "Back"
                    onClicked: stateGroup.state = "Preview"
                }

                Label {
                    text: "<H1>About text</h1><p>shalom</p>"
                }
            }
        }

        Item {
            Layout.fillHeight: true
        }

        BottomBar {
            visible: stateGroup.state === "Preview"
            onAboutClicked: {
                stateGroup.state = "About"
            }

            onRefreshClicked: {
                stateGroup.state = "LoadingData"
                Constants.refreshData()
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
            },
            State {
                name: "About"
            }
        ]
    }
}
