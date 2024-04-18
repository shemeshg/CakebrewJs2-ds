// Copyright (C) 2021 The Qt Company Ltd.
// SPDX-License-Identifier: LicenseRef-Qt-Commercial OR GPL-3.0-only
import CakebrewJs2
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Core

Window {
    width: Constants.settings.width
    height: Constants.settings.height
    x: Constants.settings.x
    y: Constants.settings.y
    Component.onDestruction: {
        Constants.settings.width = width
        Constants.settings.height = height
        Constants.settings.x = x
        Constants.settings.y = y
    }

    visible: true
    title: qsTr("Cakebrewjs")

    color: CoreSystemPalette.window

    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 10

        PreviewData {}
    }
}
