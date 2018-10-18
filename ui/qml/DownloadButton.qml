import QtQuick 2.0
import QtQuick.Layouts 1.3

Rectangle {
    function onClickHandler(){
        var delay = function(delayTime, cb) {
            var timer = Qt.createQmlObject("import QtQuick 2.0; Timer {}", root)
            timer.interval = delayTime;
            timer.repeat = false;
            timer.triggered.connect(cb);
            timer.start();
        }

        var downloadSingleVideo = function(){
            var result = downloadManager.downloadSingleVideo(url.text.toString(), destination_path.text)
            if(result === 0){
                visible = true
                download.running = false
            }
        }

        visible = false
        download.running = true
        delay(3000, downloadSingleVideo)
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
}
