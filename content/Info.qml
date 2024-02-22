import CakebrewJs2
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

ColumnLayout {        
    RowLayout {
        ComboBox {
            id: cmb
            model: ListModel {
                ListElement {
                    text: "Cask"
                }
                ListElement {
                    text: "Formula"
                }
            }
        }
        TextField {
            text: ""
            Layout.fillWidth: true
            onActiveFocusChanged: {
                if (activeFocus) {
                    selectAll()
                }
            }
        }
        Button {
            text: "Home page"
        }
        Button {
            text: "Script"
        }
    }
    TextArea {
        selectionColor: Constants.systemPalette.highlight
        selectedTextColor: Constants.systemPalette.highlightedText
        placeholderTextColor: Constants.systemPalette.text
        text:
`==> cakebrewjs: 1.4.4
https://sourceforge.net/projects/cakebrewjs/
/usr/local/Caskroom/cakebrewjs/1.4.4 (124B)
From: https://github.com/Homebrew/homebrew-cask/blob/HEAD/Casks/c/cakebrewjs.rb
==> Name
cakebrewjs
==> Description
Homebrew GUI app written in electron
==> Artifacts
cakebrewjs.app (App)
==> Analytics
install: 25 (30 days), 94 (90 days), 237 (365 days)
23M	/Users/macos/Library/Application Support/cakebrewjs
4.0K	/Users/macos/Library/Preferences/com.electron.cakebrewjs.plist`
        Layout.fillWidth: true
    }
    Label {
        text: "<h2>Formula used in</h2>"
    }
    Repeater {
        model: ["formula 1", "formula 2"]
        delegate: SearchListItem {
            itemName: modelData
            itemTag: "Cakebrewjs"
            itemVer: "2.0.0"
            itemIsInstalled: true
            itemUrl: "https://google.com"
            itemDesk: "Do things"
        }
    }
    Label {
        text: "<h2>Formula used by</h2>"
    }
    Repeater {
        model: ["formula 3", "formula 4"]
        delegate: SearchListItem {
            itemName: modelData
            itemTag: "Cakebrewjs"
            itemVer: "2.0.0"
            itemIsInstalled: true
            itemUrl: "https://google.com"
            itemDesk: "Do things"
        }
    }
    Label {
        text: "<h2>CaskRooom Folder 170M total</h2>"
    }
    HyperlinkBtn {
        urlRef: "\asdf\sadfasdf"
        urlText: "\asdf\sadfasdf"
    }
}
