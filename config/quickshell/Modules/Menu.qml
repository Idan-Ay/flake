import QtQuick
import Quickshell
import QtQuick.Controls
import Quickshell.Services.Pipewire

import qs.Components

PopupWindow {
    anchor.window: bar
    anchor.rect.x: parentWindow.width - width - 18
    anchor.rect.y: parentWindow.height
    implicitHeight: 500
    implicitWidth: 500

    color: "transparent"

    Container { // Background
        anchors.fill: parent
        indent: 10

        Column {
            id: menuColumn
            anchors {
                topMargin: 16
                rightMargin: 16
                leftMargin: 16
                top: parent.top
                left: parent.left
                right: parent.right
            }
            width: 500 - 32
            spacing: 32
            Element {
                width: menuColumn.width
                height: 32
                SText { text: "bluetooth" }
            }
            Row {
                spacing: 32
                Element {
                    width: menuColumn.width/2 - 16
                    height: 32
                    SText { text: "output" }
                }
                Element {
                    width: menuColumn.width/2 - 16
                    height: 32
                    SText { text: "input" }
                }
            }

            PwNodeLinkTracker {
                id: defaultAudioSink
                node: Pipewire.defaultAudioSink
            }
            
            PwObjectTracker {
                objects: [Pipewire.defaultAudioSink, defaultAudioSink.linkGroups]
            }

            Repeater {
                model: defaultAudioSink.linkGroups
                Rectangle {
                    width: 499 - 32
                    height: 19
                    color: "transparent"

                    
                    Column {
                        id: containSlider

                        width: 499

                        property string name: modelData.source.name
                        property real volume: modelData.source.audio.volume
                        // property real volume: 3

                        SText {
                            anchors.centerIn: null
                            text: containSlider.name
                        }

                        Slider {
                            id: slider
                            width: parent.width 
                            height: 19

                            from: -1
                            to: 0
                            stepSize: -1.01
                            live: true

                            onValueChanged: console.log(containSlider.volume)
                        }
                    }
                }
            } 
        }
    }
}