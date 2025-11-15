import QtQuick
import Quickshell

import qs.Components
import qs.Modules.Widgets

PanelWindow {

    id: bar

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

        indent: 10
    }

    WorkspaceSwitcher {}
    Clock {}

    Container {
        width: 69
        height: 23

        anchors {
            right: parent.right
            rightMargin: 12
        }
        
        bg: Qt.rgba(0.15, 0.15, 0.15, 0.75)

        Row {
            anchors.centerIn: parent
            spacing: 5
            Repeater {
                model: 3
                Rectangle {
                    width: 5
                    height: 5
                    color: "white"
                }
            }
        }
        MouseArea {
            anchors.fill: parent
            onClicked: console.log("openMenu")
        }
    }

    Menu {}
}