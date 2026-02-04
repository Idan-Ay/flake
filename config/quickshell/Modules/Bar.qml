import QtQuick
import Quickshell
import Quickshell.Services.Pipewire
import Quickshell.Bluetooth

import qs.Components
import qs.Services
import qs.Modules.Widgets

PanelWindow {

    id: bar

    Component.onCompleted: {
        Screens.mainOutput = bar.screen.name
        Screens.mainScreen = bar.screen
    }
    onScreenChanged: { 
        Screens.mainOutput = bar.screen.name
        Screens.mainScreen = bar.screen
    }

    PwObjectTracker {
        objects: [Pipewire.defaultAudioSink, Pipewire.defaultAudioSource]
    }

    property bool isMuted: Pipewire.defaultAudioSource.audio.muted
    property bool isNoSound: Pipewire.defaultAudioSink.audio.muted
    property real volume: Pipewire.defaultAudioSource.audio.volume
    property bool bluetoothOn: Bluetooth.defaultAdapter.enabled

    function volumeIconToUse() {
        if (isNoSound) {
            return "  "
        } else {
            return "  "
        }
    }

    anchors {
        top: true
        left: true
        right: true
    }

    implicitHeight: 27

    color: "transparent"

    Container { // Background
        width: bar.width - 8
        height: bar.height
    }

    WorkspaceSwitcher {}
    Clock {}

    Row {
        spacing: 12;
        anchors {
            right: parent.right
            rightMargin: 12
        }

        Row {
            Rectangle {
                width: 36
                height: 27
                color: "transparent"
                SText {
                    anchors.centerIn: parent
                    text: isNoSound ? "  " : "  "
                    color: !isNoSound ? "white" : Qt.rgba(0.5,0.5,0.5,1)
                    font.pixelSize: 15
                }
            }
            Rectangle {
                width: 36
                height: 27
                color: "transparent"
                SText {
                    anchors.centerIn: parent
                    text: isMuted ? " " : ""
                    color: !isMuted ? "white" : Qt.rgba(0.5,0.5,0.5,1)
                    font.pixelSize: 15
                }
            }
            Rectangle {
                width: 36
                height: 27
                color: "transparent"
                SText {
                    anchors.centerIn: parent
                    text: bluetoothOn ? "󰂯" : "󰂲"
                    color: bluetoothOn ? "white" : Qt.rgba(0.5,0.5,0.5,1)
                    font.pixelSize: 16
                }
            }
        }
        // Taskbar {}
        Element {
            width: 69
            height: 23


            Row {
                anchors.centerIn: parent
                spacing: 5
                Repeater {
                    model: 3
                    Rectangle {
                        width: 5
                        height: 5
                        color: "white"
                        radius: 100
                    }
                }
            }
            MouseArea {
                anchors.fill: parent
                onClicked: menu.open = !menu.open;
            }
        }

        Menu {
            id: menu
        }
    }
}
