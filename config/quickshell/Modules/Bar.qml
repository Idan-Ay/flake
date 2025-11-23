import QtQuick
import Quickshell

import qs.Components
import qs.Modules.Widgets

PanelWindow {

    id: bar

    property bool menuVisible: false

    Component.onCompleted: {
        Screens.mainOutput = bar.screen
    }
    onScreenChanged: Screens.mainOutput = bar.screen

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

    Element {
        width: 69
        height: 23

        anchors {
            right: parent.right
            rightMargin: 12
        }

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
            onClicked: menuVisible = !menuVisible;
        }
    }

    Menu {
        visible: menuVisible
    }
}