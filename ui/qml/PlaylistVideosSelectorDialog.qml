import QtQuick 2.0
import QtQuick.Controls 1.2
import QtQuick.Dialogs 1.2
import QtQuick.Window 2.3
import QtQuick.Layouts 1.3

Window {
    visible: false
    title: "Select Videos"
    width: 450
    height: 200
    color: "#00000000"

    Rectangle {
        width: 450
        height: 200
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

        ExclusiveGroup {
            id: download_mode
        }

        ColumnLayout {
            x: 8
            y: 8
            width: 434
            height: 179

            Text {
                id: help_text
                text: qsTr("How would you like download the playlist?")
                font.pixelSize: 12
            }

            RowLayout {
                RadioButton {
                    id: entire_playlist
                    text: qsTr("Entire playlist")
                    exclusiveGroup: download_mode
                    checked: true
                }
            }

            RowLayout{
                RadioButton {
                    id: slice_playlist
                    text: qsTr("Slice playlist:")
                    exclusiveGroup: download_mode

                    onCheckedChanged: {
                        if(checked){
                            selected_videos.readOnly = true
                            playlist_start.readOnly = false
                            playlist_end.readOnly = false
                        }
                    }
                }

                TextField {
                    id: playlist_start
                    placeholderText: "start"
                }

                Label {
                    text: ":"
                }

                TextField {
                    id: playlist_end
                    placeholderText: "end"
                }
            }

            RowLayout {
                Layout.fillWidth: true

                RadioButton {
                    id: some_videos
                    text: qsTr("Those videos:")
                    exclusiveGroup: download_mode

                    onCheckedChanged: {
                        if(checked){
                            selected_videos.readOnly = false
                            playlist_start.readOnly = true
                            playlist_end.readOnly = true
                        }
                    }
                }

                TextField {
                    id: selected_videos
                    placeholderText: "Vídeos to download. Ex: 2,7,10"
                    Layout.fillWidth: true
                }
            }

            RowLayout {
                Layout.fillWidth: true

                Button {
                    Layout.fillWidth: false
                    Layout.alignment: Qt.AlignLeft
                    text: "Cancel"

                    onClicked: {
                        close()
                    }
                }

                Rectangle {
                    Layout.fillWidth: true
                    color: "transparent"
                }

                Button {
                    Layout.fillWidth: false
                    Layout.alignment: Qt.AlignRight
                    text: "OK"

                    onClicked: {
                        close()
                        download_button.hideAndShowBusyIndicator()

                        var playlist = url.text.toString()
                        var path = destination_path.text.toString()
                        var playlist_items = (some_videos.checked) ? selected_videos.text.toString() : null
                        var start = (slice_playlist.checked) ? playlist_start.text.toString() : null
                        var end = (slice_playlist.checked) ? playlist_end.text.toString() : null

                        delay(3000, function(){
                            console.log(playlist)
                            console.log(path)
                            console.log(playlist_items)
                            console.log(start)
                            console.log(end)
                            downloadManager.downloadPlaylist(playlist, path, playlist_items, start, end)
                            download_button.showAndHideBusyIndicator()
                        })
                    }
                }
            }
        }
    }
}

