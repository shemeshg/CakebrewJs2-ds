pragma Singleton

import QtQuick 6.5
import QtQuick.Studio.Application
import QtQuick.Controls
import Brew
import QtCore

QtObject {
    property int width: 1000
    property int height: 800

    property Settings settings: Settings {
        property int x: 0
        property int y: 0
        property int width: 1000
        property int height: 800
    }

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

    readonly property int upgradableItemsCask: {

        return Constants.brewData.caskTableBodyList.filter(row => {
                                                               return Boolean(
                                                                   row.outdated.text)
                                                               && "tsChecked" in row.outdated
                                                           }).length
    }

    readonly property int upgradableItemsFormula: {

        return Constants.brewData.formulaTableBodyList.filter(row => {
                                                                  return Boolean(
                                                                      row.outdated.text)
                                                                  && "tsChecked" in row.outdated
                                                              }).length
    }
}
