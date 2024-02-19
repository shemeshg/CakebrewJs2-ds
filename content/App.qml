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
    property bool isError: false

    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 10

        RowLayout {
            visible: stateGroup.state === "Preview"
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
            Label {
                text: "://brew.sh"
            }
        }

        states: [
            State {
                name: "Home"
                when: btnHomeId.checked
                PropertyChanges {
                    target: label
                    text: "Home"
                }
            },
            State {
                name: "Info"
                when: btnInfoId.checked
                PropertyChanges {
                    target: label
                    text: "Info"
                }
            },
            State {
                name: "Search"
                when: btnSearchId.checked
                PropertyChanges {
                    target: label
                    text: "Search"
                }
            },
            State {
                name: "Settings"
                when: btnSettingsId.checked
                PropertyChanges {
                    target: label
                    text: "Settings"
                }
            }
        ]

        RowLayout {
            visible: stateGroup.state === "Preview"
            Label {
                id: label
                text: ""
                color: systemPalette.text
            }
        }
        Rectangle {
            visible: stateGroup.state === "LoadingData"
            Layout.fillWidth: true
            Layout.preferredHeight: 5
            color: isError ? "Dark red" : CoreSystemPalette.alternateBase
        }

        RowLayout {
            visible: stateGroup.state === "LoadingData"
            Label {
                text: "Runing: shalom\nolam"
                color: systemPalette.text
            }
        }

        Item {
            Layout.fillHeight: true
        }
        Button {
            text: "Loading data"
            onClicked: {
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
