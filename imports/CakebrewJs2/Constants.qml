pragma Singleton

import QtQuick 6.5
import QtQuick.Studio.Application
import QtQuick.Controls
import Brew

QtObject {
    readonly property int width: 800
    readonly property int height: 400

    property string relativeFontDirectory: "fonts"

    /* Edit this comment to add your custom font */
    readonly property font font: Qt.font({
                                             "family": Qt.application.font.family,
                                             "pixelSize": Qt.application.font.pixelSize
                                         })
    readonly property font largeFont: Qt.font({
                                                  "family": Qt.application.font.family,
                                                  "pixelSize": Qt.application.font.pixelSize * 1.6
                                              })

    readonly property color backgroundColor: "#EAEAEA"

    property StudioApplication application: StudioApplication {
        fontPath: Qt.resolvedUrl("../../content/" + relativeFontDirectory)
    }

    property var caskSelected: []
    property var formulaSelected: []

    property BrewData brewData: BrewData {}

    property Label dummyLabel: Label {}

    function fontSizeNormal() {
        if (!brewData.normalFontPointSize || isNaN(
                    brewData.normalFontPointSize)) {
            return dummyLabel.font.pointSize
        } else {
            return Number(brewData.normalFontPointSize)
        }
    }

    function fontSizeLarge2() {
        return fontSizeNormal() * 1.2
    }

    function fontSizeLarge3() {
        return fontSizeNormal() * 1.5
    }
}
