import QtQuick 2.9
import QtQuick.Window 2.3
import QtQuick.Controls 2.2
import QtWebView 1.1
import QtQuick.Dialogs 1.2
import QtQuick.Layouts 1.3
import QtWebEngine 1.5

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
        color: "#97d9ec"
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
            placeholderText: qsTr("Search a video (or playlist) or type the URL.")

            onAccepted: {
                search_button.executeSearch()
            }

            Keys.onTabPressed: {
                search_button.forceActiveFocus()
            }
        }

        SearchButton {
            id: search_button
            x: 526
            y: 24
        }

        WebEngineView{
            id: browser
            x: 77
            y: 66
            width: 474
            height: 314
            url:""

            profile:  WebEngineProfile {
                httpUserAgent: "Mozilla/5.0 (Linux; Android 4.0.4; Galaxy Nexus Build/IMM76B) AppleWebKit/535.19 (KHTML, like Gecko) Chrome/18.0.1025.133 Mobile Safari/535.19"
            }

            onUrlChanged: {
                if(browser.url.toString().indexOf("watch") > 0){
                    url.text = browser.url
                } else if (browser.url.toString().indexOf("playlist") > 0) {
                    url.text = browser.url
                }
            }
        }

        TextField {
            id: destination_path
            x: 77
            y: 397
            width: 437
            height: 24
            placeholderText: qsTr("Paste the path or select the destination folder.")
            text: {configurationManager.getDefaultPath()}

            Keys.onTabPressed: {
                select_folder_button.forceActiveFocus()
            }
        }

        SelectFolderButton {
            id: select_folder_button
            x: 526
            y: 397
        }

        FileDialog {
            id: folder_selection
            title: qsTr("Select the destination folder.")
            folder: shortcuts.music
            selectFolder: true

            onAccepted: {
                destination_path.text = folder_selection.folder.toString().replace("file:///", "")
                configurationManager.setDefaultPath(destination_path.text)
            }
        }

        DownloadButton {
            id: download_button
            visible: true
            y: 427
            x: 246
        }

        BusyIndicator {
            id: download
            x: 289
            y: 422
            height: 50
            width: 50

            running: false
        }
    }
}
