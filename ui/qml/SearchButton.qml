import QtQuick 2.9
import QtQuick.Window 2.3
import QtQuick.Controls 2.2
import QtWebView 1.1
import QtQuick.Dialogs 1.2

Rectangle {
    function executeSearch() {
        if(url.text.indexOf("youtube.com") > 0) {
            console.log('caiu no if')
            browser.url = url.text
        }
        else {
            console.log('caiu no else')
            browser.url = Qt.resolvedUrl("https://www.youtube.com/results?search_query=" + url.text)
        }
    }

    id: search_button
    width: 25
    height: 25
    color: "#00000000"
    radius: 2
    border.width: 1
    border.color: focus ? "blue" : "black"

    Image {
        id: search_icon
        x: 1
        y: 1
        width: 24
        height: 24
        source: "../resources/icons/baseline_search_black_18dp.png"
    }

    MouseArea {
        anchors.fill: parent
        onClicked: {
            executeSearch()
        }
    }

    Keys.onTabPressed: {
        destination_path.forceActiveFocus()
    }

    Keys.onEscapePressed: {
        executeSearch()
    }
}
