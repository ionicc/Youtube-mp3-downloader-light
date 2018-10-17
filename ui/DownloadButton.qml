import QtQuick 2.0
import QtQuick.Layouts 1.3

Rectangle {
    width: 120
    height: 33
    color: "#00000000"
    border.width: 1

    RowLayout {
        Image {
            source: "resources/icons/baseline_cloud_download_black_18dp.png"
        }

        Text {
            text: "Download MP3"
        }
    }

    MouseArea {
        anchors.fill: parent

        onClicked: {
            downloadManager.downloadMP3(url.text.toString(), destination_path.text)
        }
    }
}
