import QtQuick
import QtQuick.Controls
import Quickshell
import Quickshell.Services.Pipewire
import Quickshell.Io
import Quickshell.Wayland

import qs.Components
import qs.Services

WlrLayershell {
    layer: WlrLayer.Overlay
    keyboardFocus: WlrKeyboardFocus.OnDemand
    namespace: "dms:configMenu"

    id: panel

    visible: MenuVar.open

    function selectDevice(num) {
        switch (MenuVar.selection) {
            case "output":
                Pipewire.preferredDefaultAudioSink = DeviceService.getSinkNodes()[num]
                break
            case "input":
                Pipewire.preferredDefaultAudioSource = DeviceService.getSourceNodes()[num]
                break
            case "applications":
                MenuVar.appSelection = num
                break;
        }
    }

    anchors {
        top: true
        right: true
    }
    margins {
        top: 3
        right: 8
    }
    implicitHeight: menuColumn.height + 78
    implicitWidth: 500

    color: "transparent"

    MouseArea {
        anchors.fill: parent
        onClicked: MenuVar.open = false
    }

    Item {
        id: positioner
        anchors.fill: parent
    }

    Rectangle { // Background
        id: container

        color: Qt.rgba(0.0039, 0.0039, 0.0039, 0.9)
        radius: 4
        border {
            width: 1
            color: "white"
        }

        focus: true
        onActiveFocusChanged: {
            if (!activeFocus) {
                MenuVar.open = false
            }
        }
        Keys.onPressed: (event) => {
            switch (event.key) {
                case Qt.Key_Escape:
                    MenuVar.open = false
                    break;
                case Qt.Key_1:
                    selectDevice(0)
                    break;
                case Qt.Key_2:
                    selectDevice(1)
                    break;
                case Qt.Key_3:
                    selectDevice(2)
                    break;
                case Qt.Key_4:
                    selectDevice(3)
                    break;
                case Qt.Key_5:
                    selectDevice(4)
                    break;
                case Qt.Key_6:
                    selectDevice(5)
                    break;
                case Qt.Key_7:
                    selectDevice(6)
                    break;
                case Qt.Key_8:
                    selectDevice(7)
                    break;
                case Qt.Key_9:
                    selectDevice(8)
                    break;
                case Qt.Key_H:
                case Qt.Key_L: {
                    const delta = event.key === Qt.Key_H ? -0.1 : 0.1

                    if (MenuVar.selection === "output") {
                        DeviceService.defaultAudioSink.audio.volume += delta
                    } else if (MenuVar.selection === "input") {
                        DeviceService.defaultAudioSource.audio.volume += delta
                    } else if (MenuVar.selection === "applications") {
                        DeviceService.getSinkLinkSource()[MenuVar.appSelection].audio.volume += delta
                    }
                    break;
                }
            }
            event.accepted = true
        }

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

            Underline {
                SText {
                    text: "audio settings"
                }
                width: menuColumn.width
                height: 24
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

                        Underline {
                            SText {
                                text: (MenuVar.selection==="output" ? "* " : "") + "output"
                            }
                            width: menuColumn.width - 14
                            height: 24
                        }

                        width: outputSwitcher.width - 16

                        Repeater {
                            model: DeviceService.getSinkNodes()
                            Rectangle {

                                width: parent.width
                                height: 19

                                color: "transparent"

                                SText {
                                    text: index+1 + ". " + (modelData.description || modelData.name)
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

                        Underline {
                            SText {
                                text: (MenuVar.selection==="input" ? "* " : "") + "input"
                            }
                            width: menuColumn.width - 14
                            height: 24
                        }

                        width: inputSwitcher.width - 16

                        Repeater {
                            model: DeviceService.getSourceNodes()
                            Rectangle {

                                width: parent.width
                                height: 19

                                color: "transparent"

                                SText {
                                    text: index+1 + ". " + (modelData.description || modelData.name)
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

            Column {
                width: 499 - 32
                height: 19
                SText {
                    anchors.centerIn: null
                    text: (MenuVar.selection==="output" ? "* " : "") + "output"
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
                    text: (MenuVar.selection==="input" ? "* " : "") + "input"
                }
                SSlider {
                    value: Pipewire.defaultAudioSource.audio.volume
                    onValueChanged: Pipewire.defaultAudioSource.audio.volume = value
                }
            }

            Column {
                spacing: 16
                SText {
                    text: (MenuVar.selection==="applications" ? "* " : "") + "applications:"
                    height: 48
                    verticalAlignment: Text.AlignBottom
                }
                Repeater {
                    model: DeviceService.getSinkLinkSource()

                    Rectangle {
                        width: 499 - 32
                        height: 32
                        color: "transparent"

                        Column {
                            id: containSlider

                            width: 499

                            property string name: modelData.name

                            SText {
                                anchors.centerIn: null
                                text: (MenuVar.selection==="applications" && MenuVar.appSelection === index ? "* " : "") + (index+1) + ". " + containSlider.name
                            }

                            SSlider {
                                id: slider

                                width: parent.width -32

                                value: modelData.audio.volume
                                onValueChanged: modelData.audio.volume = value
                            }
                        }
                    }
                } 
            }
        }
    }
}
