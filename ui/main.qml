import QtQuick 2.9
import QtQuick.Window 2.3
import QtQuick.Controls 2.2
import QtWebView 1.1
import QtQuick.Dialogs 1.2

Window{
    id: root
    visible: true
    width: 640
    height: 480
    title: "Youtube MP3 Downloader Light"

    Rectangle {
        id: main
        x: 0
        y: 0
        width: 640
        height: 480
        border.width: 0
        gradient: Gradient {
            GradientStop {
                position: 0
                color: "#97d9ec"
            }

            GradientStop {
                position: 1
                color: "#d2fff8"
            }
        }

        TextField {
            id: url
            x: 77
            y: 24
            width: 437
            height: 24
            placeholderText: qsTr("Search a video or type the URL.")
        }

        Rectangle {
            id: search_button
            x: 526
            y: 24
            width: 25
            height: 25
            color: "#00000000"
            radius: 2
            border.width: 1

            Image {
                id: search_icon
                x: 1
                y: 1
                width: 24
                height: 24
                source: "resources/icons/baseline_search_black_18dp.png"
            }

            MouseArea {
                anchors.fill: parent
                onClicked: {
                    console.log(url.text)
                    if(url.text.indexOf("youtube.com") > 0) {
                        console.log('caiu no if')
                        browser.url = url.text
                    }
                    else {
                        console.log('caiu no else')
                        browser.url = "https://www.youtube.com/results?search_query=" + url.text
                    }
                }
            }
        }

        WebView{
            id: browser
            x: 77
            y: 66
            width: 474
            height: 314
            url:""
        }

        TextField {
            id: destination_path
            x: 77
            y: 397
            width: 437
            height: 24
            placeholderText: qsTr("Paste the path or select the destination folder.")
        }

        Rectangle {
            id: select_folder_button
            x: 526
            y: 397
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

                }
            }
        }
    }
}
