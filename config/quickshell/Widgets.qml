import QtQuick
import Quickshell
import QtQuick.Effects
import Quickshell.Widgets
import Quickshell.Wayland
import Quickshell.Io

Row {

    id: root

    spacing: 8

    Container {
        height: 556
        width: 380

        Column {
            spacing: 38

            anchors.centerIn: parent

            Item {
                anchors.horizontalCenter: parent.horizontalCenter
                width: 240
                height: width
                Image {
                    id: profileImageLoader
                    source: "profile.png"
                    
                    anchors.fill: parent

                    fillMode: Image.PreserveAspectCrop

                    smooth: true
                    asynchronous: true
                    mipmap: true
                    cache: true
                    visible: false
                }

                MultiEffect {
                    anchors.fill: parent
                    source: profileImageLoader
                    maskEnabled: true
                    maskSource: circularMask
                    visible: true
                    maskThresholdMin: 0.5
                    maskSpreadAtMin: 1
                }

                Item {
                    id: circularMask
                    anchors.fill: parent
                    layer.enabled: true
                    layer.smooth: true
                    visible: false
                    
                    Rectangle {
                        anchors.fill: parent
                        radius: width / 2
                        color: "black"
                        antialiasing: true
                    }
                }
            }

            Column {
                anchors.horizontalCenter: parent.horizontalCenter
                Text {
                    text: ('> user."'+Quickshell.env("USER")+'"' || "unknown")
                    
                    color: "white"
                    font.pixelSize: 20
                    font.bold: true
                }
                Text {
                    text: '> compositor."niri"'

                    color: "white"
                    font.pixelSize: 20
                    font.bold: true
                }
                Text {
                    text: '> system."nixos"'

                    color: "white"
                    font.pixelSize: 20
                    font.bold: true
                }
            }
        }
    }

    Timer {
        interval: 1000
        running: true
        repeat: true
        onTriggered: {
            time.text = Qt.formatDateTime(new Date(), "hh:mm")
            date.text = Qt.formatDateTime(new Date(), "ddd, dd.MM.yyyy")
        }
    }

    Column {
        spacing: 8
        
        Container {
            height: 180
            width: 368
            
            Rectangle {
                anchors.centerIn: parent
                width: 312
                height: 96

                color: "transparent"

                Column {
                    Text {
                        id: time
                        text: Qt.formatDateTime(new Date(), "hh:mm")
                        color: "white"
                        font.pixelSize: 50
                        font.bold: true
                    }
                    Text {
                        id: date
                        text: Qt.formatDateTime(new Date(), "ddd, dd.MM.yyyy")
                        color: "white"
                        font.pixelSize: 26
                    }
                }
            }
        }

        Container {
            id: appGrid

            height: 368
            width: 368

            property var apps: [
                {icon: "brave-browser", exec: "brave"},
                {icon: "vscode", exec: "code"},
                {icon: "foot", exec: "foot"},
                {icon: "blender", exec: "blender"},
                {icon: "obsidian", exec: "obsidian"},
                {icon: "org.xfce.thunar", exec: "f lf"},
                {icon: "gimp", exec: "gimp"},
                {icon: "blueman", exec: "blueman-manager"},
                {icon: "pavucontrol", exec: "pavucontrol"}
            ]

            Grid {
                columns: 3
                spacing: 12
                anchors.centerIn: parent

                Repeater {
                    model: appGrid.apps

                    delegate: Rectangle {
                        width: 78
                        height: 78
                        radius: 12
                        color: Qt.rgba(5, 5, 5, 0.05);

                        IconImage {
                            id: appIcon
                            anchors.centerIn: parent
                            width: 50
                            height: 50

                            source: (modelData.icon || "").startsWith("/")
                                ? modelData.icon
                                : Quickshell.iconPath(modelData.icon, true)
                        }

                        MouseArea {
                            anchors.fill: parent
                            onClicked: Quickshell.execDetached(modelData.exec)
                        }
                    }
                }
            }
        }
    }

    property bool powerOffConfirm: false
    property bool rebootConfirm: false
    property bool suspendConfirm: false

    function tryPowerOff() {

        if (!powerOffConfirm) {
            powerOffConfirm = true
            falsePowerOffConfirm.start()
        } else {
            Quickshell.execDetached("poweroff")
        }
    }
    Timer {
        id: falsePowerOffConfirm
        interval: 1000
        onTriggered: powerOffConfirm = false
    }

    function tryReboot() {

        if (!rebootConfirm) {
            rebootConfirm = true
            falseRebootConfirm.start()
        } else {
            Quickshell.execDetached("reboot")
        }
    }
    Timer {
        id: falseRebootConfirm
        interval: 1000
        onTriggered: rebootConfirm = false
    }

    function trySuspend() {

        if (!suspendConfirm) {
            suspendConfirm = true
            falseSuspendConfirm.start()
        } else {
            Quickshell.execDetached(["systemctl", "suspend"])
        }
    }
    Timer {
        id: falseSuspendConfirm
        interval: 1000
        onTriggered: suspendConfirm = false
    }

    Column {
        spacing: 8

        Container {
            height: 180
            width: height
            
            Text {
                anchors.centerIn: parent
                text: ""
                color: "white"
                font.pixelSize: 50
            }

            border.color: root.powerOffConfirm ? "white" : "transparent"
            border.width: root.powerOffConfirm ? 2 : 0

            Behavior on border.width { NumberAnimation { duration: 120; easing.type: Easing.OutQuad } }
            Behavior on border.color { ColorAnimation { duration: 120; easing.type: Easing.OutQuad } }

            MouseArea {
                anchors.fill: parent
                onClicked: root.tryPowerOff()
            }
        }

        Container {
            height: 180
            width: height
            
            Text {
                anchors.centerIn: parent
                text: "󰜉"
                color: "white"
                font.pixelSize: 62
            }

            border.color: root.rebootConfirm ? "white" : "transparent"
            border.width: root.rebootConfirm ? 2 : 0

            Behavior on border.width { NumberAnimation { duration: 120; easing.type: Easing.OutQuad } }
            Behavior on border.color { ColorAnimation { duration: 120; easing.type: Easing.OutQuad } }

            MouseArea {
                anchors.fill: parent
                onClicked: root.tryReboot()
            }
        }

        Container {
            height: 180
            width: height
            
            Text {
                anchors.centerIn: parent
                text: ""
                color: "white"
                font.pixelSize: 62
            }

            border.color: root.suspendConfirm ? "white" : "transparent"
            border.width: root.suspendConfirm ? 2 : 0

            Behavior on border.width { NumberAnimation { duration: 120; easing.type: Easing.OutQuad } }
            Behavior on border.color { ColorAnimation { duration: 120; easing.type: Easing.OutQuad } }

            MouseArea {
                anchors.fill: parent
                onClicked: root.trySuspend()
            }
        }
    }
}