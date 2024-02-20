import CakebrewJs2
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

RowLayout {
    ColumnLayout {
        Label {
            text: `
            <h2>Credits</h2>
            <p>Icons made by Freepik from www.flaticon.com</p>
            <p>https://github.com/shemeshg/cakebrewjs</p>
            <h2>License</h2>
            <p>Copyright 2020 shemeshg</p>
            <p>Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:</p>
            <p>The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.</p>
            <p>THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.</p>
            `
            wrapMode: Text.WordWrap
            Layout.fillWidth: true
        }
        Item {
            Layout.fillHeight: true
        }
    }
}
