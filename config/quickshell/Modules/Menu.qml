import QtQuick
import QtQuick.Controls
import Quickshell
import Quickshell.Services.Pipewire
import Quickshell.Bluetooth

import qs.Components

PopupWindow {
    anchor.window: bar
    anchor.rect.x: parentWindow.width - width - 18
    anchor.rect.y: parentWindow.height
    implicitHeight: menuColumn.height + 78
    implicitWidth: 500

    color: "transparent"

    Container { // Background
        anchors.fill: parent

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
                height: bluetoothDeviceColumn.height + 19

                Column {
                    spacing: 4

                    Rectangle {
                        width: parent.width
                        height: 19
                        color: "transparent"
                        SText { text: "bluetooth" }
                        Row {
                            spacing: 12
                            anchors.right: parent.right
                            Rectangle {
                                width: 19
                                height: 19

                                color: "transparent"

                                SText {
                                    text: "R"
                                    anchors.centerIn: parent
                                    color: Bluetooth.defaultAdapter.discovering ? "grey" : "white"
                                }
                                MouseArea {
                                    anchors.fill: parent
                                    onClicked: {
                                        if (!Bluetooth.defaultAdapter.discovering) {
                                            Bluetooth.defaultAdapter.discovering = true
                                            waitForDiscoveringDisable.start()
                                        }
                                    }
                                }
                                Timer {
                                    id: waitForDiscoveringDisable
                                    interval: 5000;
                                    onTriggered: Bluetooth.defaultAdapter.discovering = false
                                }
                            }
                            Switch {
                                checked: Bluetooth.defaultAdapter.enabled
                                onClicked: Bluetooth.defaultAdapter.enabled = checked
                                height: 19
                                width: 32
                            }
                        }
                    }
                    Rectangle {
                        width: menuColumn.width - 14
                        height: 1
                    }

                    id: bluetoothDeviceColumn
                    width: menuColumn.width - 16
                    Repeater {
                        model: Bluetooth.devices
                        Rectangle {
                            id: deviceElement

                            width: parent.width
                            height: 19

                            color: "transparent"

                            property bool forgetting: false

                            SText {
                                text: modelData.name + " (" + modelData.icon + ") " +
                                        (modelData.betteryAvailable ? modelData.battery + "%" : "") +
                                        (modelData.state === 1 ? "connected" : "") +
                                        (modelData.state === 3 ? "connecting..." : "") +
                                        (modelData.state === 0 ? "disconnected" : "") +
                                        (deviceElement.forgetting ? " | forgetting..." : "")
                            }

                            MouseArea {
                                width: parent.width - 20
                                height: parent.height
                                onClicked: {
                                    modelData.pair()
                                    modelData.connect()
                                }
                            }

                            Row {
                                anchors {
                                    verticalCenter: parent.verticalCenter
                                    right: parent.right
                                }
                                    
                                Rectangle {
                                    enabled: modelData.paired
                                    visible: modelData.paired

                                    width: 19
                                    height: 19

                                    color: "transparent"

                                    SText {
                                        text: "d"
                                        anchors.centerIn: parent
                                    }
                                    MouseArea {
                                        anchors.fill: parent
                                        onClicked: {
                                            modelData.disconnect()
                                        }
                                    }
                                }

                                Rectangle {
                                    enabled: modelData.paired
                                    visible: modelData.paired

                                    width: 19
                                    height: 19

                                    color: "transparent"

                                    SText {
                                        text: "f"
                                        anchors.centerIn: parent
                                    }
                                    MouseArea {
                                        anchors.fill: parent
                                        onClicked: {
                                            deviceElement.forgetting = true
                                            modelData.forget()
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }

            Row {
                spacing: 32
                Element {
                    id: outputSwitcher
                    width: menuColumn.width/2 - 16
                    height: outputColumn.height + 19
                    
                    Column {
                        id: outputColumn
                        spacing: 4

                        SText { text: "output" }

                        Rectangle {
                            width: outputSwitcher.width - 14
                            height: 1
                        }

                        width: outputSwitcher.width - 16

                        function getSinkNodes() {
                            let sinkNodes = []
                            for (const node of Pipewire.nodes.values) {
                                if (node.isSink && !node.isStream) {
                                    sinkNodes.push(node)
                                }
                            }
                            return sinkNodes
                        }
                        Repeater {
                            model: outputColumn.getSinkNodes()
                            Rectangle {

                                width: parent.width
                                height: 19

                                color: "transparent"

                                SText {
                                    text: modelData.description || modelData.name
                                    width: parent.width - 12
                                    elide: Text.ElideRight
                                }

                                Rectangle {
                                    visible: modelData === Pipewire.defaultAudioSink
                                    width: 4
                                    height: 4
                                    radius: 100
                                    color: "white"
                                    anchors {
                                        verticalCenter: parent.verticalCenter
                                        right: parent.right
                                    }
                                }

                                MouseArea {
                                    width: parent.width - 20
                                    height: parent.height
                                    onClicked: {
                                        Pipewire.preferredDefaultAudioSink = modelData
                                    }
                                }
                            }
                        }
                    }
                }
                Element {
                    id: inputSwitcher
                    width: menuColumn.width/2 - 16
                    height: inputColumn.height + 19
                    Column {
                        id: inputColumn
                        spacing: 4

                        SText { text: "input" }

                        Rectangle {
                            width: inputSwitcher.width - 14
                            height: 1
                        }

                        width: inputSwitcher.width - 16

                        function getSourceNodes() {
                            let sinkNodes = []
                            for (const node of Pipewire.nodes.values) {
                                if (!node.isSink && !node.isStream && node.audio) {
                                    sinkNodes.push(node)
                                }
                            }
                            return sinkNodes
                        }
                        Repeater {
                            model: inputColumn.getSourceNodes()
                            Rectangle {

                                width: parent.width
                                height: 19

                                color: "transparent"

                                SText {
                                    text: modelData.description || modelData.name
                                    width: parent.width - 12
                                    elide: Text.ElideRight
                                }

                                Rectangle {
                                    visible: modelData === Pipewire.defaultAudioSource
                                    width: 4
                                    height: 4
                                    radius: 100
                                    color: "white"
                                    anchors {
                                        verticalCenter: parent.verticalCenter
                                        right: parent.right
                                    }
                                }

                                MouseArea {
                                    width: parent.width - 20
                                    height: parent.height
                                    onClicked: {
                                        Pipewire.preferredDefaultAudioSource = modelData
                                    }
                                }
                            }
                        }
                    }
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

            SText {
                text: "applications:"
                height: 46
                verticalAlignment: Text.AlignBottom
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
