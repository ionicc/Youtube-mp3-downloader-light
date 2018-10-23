import QtQuick 2.0
import QtQuick.Layouts 1.3

Rectangle {
    function hideAndShowBusyIndicator() {
        visible = false
        download.running = true
    }

    function showAndHideBusyIndicator() {
        visible = true
        download.running = false
    }

    function downloadSingleVideo(url, path){
        var result = downloadManager.downloadSingleVideo(url, path)
        if(result === 0){
            showAndHideBusyIndicator()
        }
    }

    function downloadPlaylist(url, path, playlist_items, playlist_start, playlist_end){
        var result = downloadManager.downloadPlaylist(url, path, playlist_items, playlist_start, playlist_end)
    }

    function onClickHandler(){
        if (browser.url.toString().indexOf("playlist") > 0) {
            playlist_videos_selector_dialog.show()
        } else {
            hideAndShowBusyIndicator()
            delay(3000, function(){
                downloadSingleVideo(url.text.toString(), destination_path.text)
            })
        }
    }

    width: 120
    height: 33
    color: "#00000000"
    border.width: 1
    border.color: focus ? "blue" : "black"

    RowLayout {
        Image {
            source: "../resources/icons/baseline_cloud_download_black_18dp.png"
        }

        Text {
            text: "Download MP3"
        }
    }

    MouseArea {
        anchors.fill: parent

        onClicked: {
            onClickHandler()
        }
    }

    Keys.onEscapePressed: {
        onClickHandler()
    }

    Keys.onEnterPressed: {
        onClickHandler()
    }
}
