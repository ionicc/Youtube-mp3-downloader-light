import QtQuick 2.0
import QtQuick.Layouts 1.3

Rectangle {
    width: 120
    height: 33
    color: "#00000000"
    border.width: 1

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
            var delay = function(delayTime, cb) {
                var timer = Qt.createQmlObject("import QtQuick 2.0; Timer {}", root)
                timer.interval = delayTime;
                timer.repeat = false;
                timer.triggered.connect(cb);
                timer.start();
            }

            var download_music = function(){
                var result = downloadManager.downloadSingleVideo(url.text.toString(), destination_path.text)
                if(result === 0){
                    download_button.visible = true
                    download.running = false
                }
            }


            download_button.visible = false
            download.running = true
            delay(3000, download_music)
        }
    }
}
