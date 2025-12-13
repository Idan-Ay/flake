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

            function volumesToBound() {
                let bound = []
                for (const group of defaultAudioSink.linkGroups) {
                    console.log("update")
                    bound.push( group.source.audio.volume )
                }
                return bound
            }
            
            // PwObjectTracker {
            //     objects: menuColumn.volumesToBound()
            // }

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
                        property real volume: modelData.source.audio.volume
                        // property real volume: 3

                        SText {
                            anchors.centerIn: null
                            text: containSlider.name
                        }

                        SSlider {
                            id: slider
                            stepSize: 0.01

                            value: modelData.source.audio.volume

                            onValueChanged: {modelData.source.audio.volume = value
                            console.log(value)}
                        }
                    }
                }
            } 
        }
    }
}