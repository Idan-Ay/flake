import QtQuick
import Quickshell
import Quickshell.Services.Pipewire

import qs.Modules.Widgets


PopupWindow {
    id: indicator

    visible: false
    anchor.window: bar
    anchor.rect.x: bar.width / 2 - width / 2
    anchor.rect.y: 120
    implicitHeight: 120
    implicitWidth: 120
    color: "transparent"

    property string symbol
    property bool highlight

    PwObjectTracker {
        objects: [Pipewire.defaultAudioSource, Pipewire.defaultAudioSink]
    }

    Connections {
        target: Pipewire.defaultAudioSource.audio
        onMutedChanged: {
            indicator.symbol = Pipewire.defaultAudioSource.audio.muted ? "  " : ""
            indicator.highlight = Pipewire.defaultAudioSource.audio.muted
            indicator.visible = true
            hideDelay.stop()
            hideDelay.start()
        }
    }

    Connections {
        target: Pipewire.defaultAudioSink.audio
        onMutedChanged: {
            indicator.symbol = Pipewire.defaultAudioSink.audio.muted ? " " : " "
            indicator.highlight = Pipewire.defaultAudioSink.audio.muted
            indicator.visible = true
            hideDelay.stop()
            hideDelay.start()
        }
    }

    Timer {
        id: hideDelay
        interval: 400
        onTriggered: indicator.visible = false
    }

    Rectangle {
        anchors.fill: parent
        color: Qt.rgba(0,0,0,0.95)
        radius: 6
        border {
            color: "white"
            width: 1
        }
        Text {
            text: indicator.symbol
            font.pointSize: 28
            color: highlight ? "gray" : "white"
            anchors.centerIn: parent
        }
    }
}
