import Quickshell
import QtQuick
import Quickshell.Widgets
import Quickshell.Services.Pipewire

Row {
    PwObjectTracker {
        objects: [Pipewire.defaultAudioSink, Pipewire.defaultAudioSource]
    }

    id: sound

    anchors.verticalCenter: parent.verticalCenter

    spacing: 10

    // Bind the node so audio.* properties are valid & reactive
    property var defaultAudioSink: Pipewire.defaultAudioSink
    property real volume: defaultAudioSink && defaultAudioSink.audio
        ? defaultAudioSink.audio.volume
        : 0
    property bool volumeMuted: defaultAudioSink && defaultAudioSink.audio
        ? defaultAudioSink.audio.muted
        : false

    property var defaultAudioSource: Pipewire.defaultAudioSource
        property bool inputMuted: defaultAudioSource && defaultAudioSource.audio
            ? defaultAudioSource.audio.muted
            : true

    Box {
        anchors.verticalCenter: parent.verticalCenter
        width: 42

        Text {
            anchors.centerIn: parent

            text: !sound.inputMuted ? "" : " "

            font.pixelSize: 18
            color: !sound.inputMuted ? "white" : "gray"
        }
    }

    Box {
        anchors.verticalCenter: parent.verticalCenter
        width: 250

        Row {
            anchors.centerIn: parent
            spacing: 4
            Rectangle {
                anchors.verticalCenter: parent.verticalCenter
                width: 13
                height: 20
                color: "transparent"
                Text {
                    anchors.centerIn: parent
                    text: ""
                    color: sound.volume !== 0 ? "white" : "gray"
                    font.pixelSize: 20
                    font.bold: true
                }
            }
            Repeater {
                model: 10
                Rectangle {
                    anchors.verticalCenter: parent.verticalCenter
                    height: 14
                    width: 4
                    radius: 100
                    color: index+1 <= Math.round(sound.volume * 20) ? "white" : "gray"
                }
            }
            Rectangle {
                anchors.verticalCenter: parent.verticalCenter
                color: "transparent"
                width: 42
                height: 14
                Text {
                    anchors.centerIn: parent
                    color: "white"
                    font.pixelSize: 14
                    font.bold: true

                    text: !sound.volumeMuted ? Math.round(sound.volume * 100) + "%" : "---"
                }
            }
            Repeater {
                model: 10
                Rectangle {
                    anchors.verticalCenter: parent.verticalCenter
                    height: 14
                    width: 4
                    radius: 100
                    color: index+11 <= Math.round(sound.volume * 20) ? "white" : "gray"
                }
            }
        }
    }
}