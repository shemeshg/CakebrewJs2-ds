import CakebrewJs2
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Core
import Brew

HyperlinkBtn {
    property bool isCask: true
    onLinkActivated: data => {
                         var tag = isCask ? "Cask" : "Formula"
                         headerToolbarId.btnInfoId.checked = true
                         previewData.state = "Info"
                         info.cmb.currentIndex = info.cmb.indexOfValue(tag)
                         info.token.text = data
                         info.infoBtn.clicked()
                     }

}
