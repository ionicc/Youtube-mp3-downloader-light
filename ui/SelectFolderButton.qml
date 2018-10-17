import QtQuick 2.9
import QtQuick.Window 2.3
import QtQuick.Controls 2.2
import QtWebView 1.1
import QtQuick.Dialogs 1.2

Rectangle {
    id: select_folder_button
    width: 25
    height: 25
    color: "#00000000"
    radius: 2
    border.width: 1
    
    Image {
        id: folder_icon
        x: 1
        y: 1
        width: 24
        height: 24
        source: "resources/icons/baseline_folder_black_18dp.png"
    }
    
    MouseArea {
        anchors.fill: parent
        onClicked: {
            folder_selection.visible = true
        }
    }
}
