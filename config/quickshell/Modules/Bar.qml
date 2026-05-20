import QtQuick
import Quickshell
import Quickshell.Wayland
import Quickshell.Io

import qs.Components
import qs.Services
import qs.Modules.Widgets

PanelWindow {
    id: bar

    WlrLayershell.namespace: "dms:bar"

    property string screenName
    property bool menuOpen: false

    Component.onCompleted: {
        bar.screenName = bar.screen.name
    }
    onScreenChanged: { 
        bar.screenName = bar.screen.name
    }

    property bool isBigBar: bar.width > 1700
    // property bool isBigBar: false

    anchors {
        top: true
        left: true
        right: true
    }
    margins {
        right: 8
    }

    implicitHeight: 27

    color: "transparent"

    Container {
        id: container

        width: parent.width
        height: 27

        anchors.bottom: parent.bottom

        Row {
            spacing: 18;
            WorkspaceSwitcher {
                screenName: bar.screenName
            }
            Resources {}
        }

        Clock {}

        Row {
            spacing: 12;
            anchors {
                right: parent.right
                rightMargin: 6
            }

            ActiveServices {}
            Battery {}

            // Taskbar {}
            Loader {
                visible: isBigBar
                sourceComponent: Media{}
            }
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
                    onClicked: MenuVar.open = !MenuVar.open
                }
            }

            IpcHandler {
                target: "open-menu"

                function bluetooth() {
                    MenuVar.open = true
                    MenuVar.selection = "bluetooth"
                }
                function output() {
                    MenuVar.open = true
                    MenuVar.selection = "output"
                }
                function input() {
                    MenuVar.open = true
                    MenuVar.selection = "input"
                }
                function applications() {
                    MenuVar.open = true
                    MenuVar.selection = "applications"
                }
            }

            Menu {}
        }
    }
}

