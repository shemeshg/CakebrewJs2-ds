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
        LoadingData {
            visible: stateGroup.state === "LoadingData"
        }

        Item {
            Layout.fillHeight: true
        }

        GroupBox {
            id: groupBox
            Layout.fillWidth: true
            RowLayout {
                anchors.left: parent.left
                anchors.right: parent.right

                Button {
                    text: "Refresh"
                    onClicked: {
                        console.log("asdasdasd")
                        if (stateGroup.state === "Preview") {
                            stateGroup.state = "LoadingData"
                        } else {
                            stateGroup.state = "Preview"
                        }
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
