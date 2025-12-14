import QtQuick
import Quickshell
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
                objects: [Pipewire.defaultAudioSink, Pipewire.defaultAudioSource]
            }

            Column {
                width: 499 - 32
                height: 19
                SText {
                    anchors.centerIn: null
                    text: "output"
                }
                SSlider {
                    value: Pipewire.defaultAudioSink.audio.volume
                    onValueChanged: Pipewire.defaultAudioSink.audio.volume = value
                }
            }
            Column {
                width: 499 - 32
                height: 19
                SText {
                    anchors.centerIn: null
                    text: "input"
                }
                SSlider {
                    value: Pipewire.defaultAudioSource.audio.volume
                    onValueChanged: Pipewire.defaultAudioSource.audio.volume = value
                }
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

                        PwObjectTracker {
                            objects: [modelData.source]
                        }

                        property string name: modelData.source.name

                        SText {
                            anchors.centerIn: null
                            text: containSlider.name
                        }

                        SSlider {
                            id: slider

                            width: parent.width -32

                            value: modelData.source.audio.volume
                            onValueChanged: modelData.source.audio.volume = value
                        }
                    }
                }
            } 
        }
    }
}