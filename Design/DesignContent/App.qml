// Copyright (C) 2021 The Qt Company Ltd.
// SPDX-License-Identifier: LicenseRef-Qt-Commercial OR GPL-3.0-only
import Design
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Core

Window {
    width: Constants.brewData.width
    height: Constants.brewData.height
    x: Constants.brewData.x
    y: Constants.brewData.y
    Component.onDestruction: {
        Constants.brewData.saveWidth(width)
        Constants.brewData.saveHeight(height)
        Constants.brewData.saveX(x)
        Constants.brewData.saveY(y)
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
