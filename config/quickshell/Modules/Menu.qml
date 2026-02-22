import QtQuick
import QtQuick.Controls
import Quickshell
import Quickshell.Services.Pipewire
import Quickshell.Bluetooth
import Quickshell.Io
import Quickshell.Wayland

import qs.Components

WlrLayershell {
    layer: open ? WlrLayer.Overlay : WlrLayer.Top
    keyboardFocus: WlrKeyboardFocus.OnDemand  // or Exclusive for full control

    id: panel

    PwNodeLinkTracker {
        id: defaultAudioSink
        node: Pipewire.defaultAudioSink
    }

    PwObjectTracker {
        objects: [Pipewire.defaultAudioSink, Pipewire.defaultAudioSource]
    }

    property bool open: false
    property string selection
    property int appSelection: 0
    visible: open

    IpcHandler {
        target: "open-menu"

        function bluetooth() {
            open = true
            selection = "bluetooth"
        }
        function output() {
            open = true
            selection = "output"
        }
        function input() {
            open = true
            selection = "input"
        }
        function applications() {
            open = true
            selection = "applications"
        }
    }

    function getSourceNodes() {
        let sourceNodes = []
        for (const node of Pipewire.nodes.values) {
            if (!node.isSink && !node.isStream && node.audio) {
                sourceNodes.push(node)
            }
        }
        return sourceNodes
    }
    function getSinkNodes() {
        let sinkNodes = []
        for (const node of Pipewire.nodes.values) {
            if (node.isSink && !node.isStream) {
                sinkNodes.push(node)
            }
        }
        return sinkNodes
    }

    function selectDevice(num) {
        if (selection === "bluetooth") {
            if (Bluetooth.devices.values[num].connected) {
                Bluetooth.devices.values[num].disconnect()
            } else {
                Bluetooth.devices.values[num].connect()
            }
        }
        if (selection === "output") {
            Pipewire.preferredDefaultAudioSink = getSinkNodes()[num]
        }
        if (selection === "input") {
            Pipewire.preferredDefaultAudioSource = getSourceNodes()[num]
        }
        if (selection === "applications") {
            appSelection = num
        }
    }

    anchors {
        top: true
        right: true
        left: true
        bottom: true
    }

    color: "transparent"

    MouseArea {
        anchors.fill: parent
        onClicked: panel.open = false
    }

    Item {
        id: positioner
        anchors.fill: parent
    }

    ContainerBTLS { // Background
        focus: true


        Keys.onPressed: (event) => {
            switch (event.key) {
                case Qt.Key_Escape:
                    open = false
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

                    if (selection === "output") {
                        Pipewire.defaultAudioSink.audio.volume += delta
                    } else if (selection === "input") {
                        Pipewire.defaultAudioSource.audio.volume += delta
                    } else if (selection === "applications") {
                        defaultAudioSink.linkGroups[appSelection].source.audio.volume += delta
                    }
                    break;
                }
                case Qt.Key_R:
                    if (selection === "bluetooth") {
                        Bluetooth.defaultAdapter.discovering = true
                        waitForDiscoveringDisable.start()
                    }
                    break;
                case Qt.Key_D:
                    if (selection === "bluetooth") {
                        Bluetooth.defaultAdapter.enabled = !Bluetooth.defaultAdapter.enabled
                    }
                    break;
            }
            event.accepted = true
        }


        height: menuColumn.height + 78
        width: 500

        anchors {
            rightMargin: 6 + 8
            right: positioner.right
        }

        color: Qt.rgba(0,0,0,0.9)

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
                        SText { text: (selection==="bluetooth" ? "* " : "") + "bluetooth" }
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
                                text: index+1 + ". " + modelData.name + " (" + modelData.icon + ") " +
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
                                    modelData.connect()
                                }
                            }

                            Rectangle {
                                anchors.right: parent.right

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

                        SText { text: (selection==="output" ? "* " : "") + "output" }

                        Rectangle {
                            width: outputSwitcher.width - 14
                            height: 1
                        }

                        width: outputSwitcher.width - 16

                        Repeater {
                            model: getSinkNodes()
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

                        SText { text: (selection==="input" ? "* " : "") + "input" }

                        Rectangle {
                            width: inputSwitcher.width - 14
                            height: 1
                        }

                        width: inputSwitcher.width - 16

                        Repeater {
                            model: getSourceNodes()
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
                    text: (selection==="output" ? "* " : "") + "output"
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
                    text: (selection==="input" ? "* " : "") + "input"
                }
                SSlider {
                    value: Pipewire.defaultAudioSource.audio.volume
                    onValueChanged: Pipewire.defaultAudioSource.audio.volume = value
                }
            }

            SText {
                text: (selection==="applications" ? "* " : "") + "applications:"
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
                            text: (selection==="applications" && appSelection === index ? "* " : "") + (index+1) + ". " + containSlider.name
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
