import QtQuick
import Quickshell
import Quickshell.Services.Pipewire
import Quickshell.Services.Mpris
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
            BarIcon {
                text: isNoSound ? "  " : "  "
                active: !isNoSound
            }
            BarIcon {
                text: isMuted ? " " : ""
                active: !isMuted
            }
            BarIcon {
                text: bluetoothOn ? "󰂯" : "󰂲"
                active: bluetoothOn
            }
        }

        Rectangle {
            width: 360
            height: bar.height - 4

            color: "transparent"

            SText {
                text: Mpris.players.values[0]?.trackTitle ?? "No track playing"
                elide: Text.ElideRight
                width: 280
                // text: Mpris.players.values[0].length
                anchors.verticalCenter: parent.verticalCenter
            }
            Row {
                anchors.right: parent.right
                Rectangle {
                    height: bar.height - 4
                    width: height
                    color: "transparent"
                    SText {
                        anchors.centerIn: parent
                        text: ""
                    }
                    MouseArea {
                        anchors.fill: parent
                        onClicked: Mpris.players.values[0]?.previous()
                    }
                }
                Rectangle {
                    height: bar.height - 4
                    width: height
                    color: "transparent"
                    SText {
                        anchors.centerIn: parent
                        text: Mpris.players.values[0]?.isPlaying ? "" : ""
                    }
                    MouseArea {
                        anchors.fill: parent
                        onClicked: Mpris.players.values[0]?.togglePlaying() 
                    }
                }
                Rectangle {
                    height: bar.height - 4
                    width: height
                    color: "transparent"
                    SText {
                        anchors.centerIn: parent
                        text: ""
                    }
                    MouseArea {
                        anchors.fill: parent
                        onClicked: Mpris.players.values[0]?.next()
                    }
                }
            }

            Rectangle {
                width: parent.width
                height: 1
                anchors.bottom: parent.bottom
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
