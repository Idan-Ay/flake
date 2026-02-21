import QtQuick
import Quickshell

import qs.Components
import qs.Services
import qs.Modules.Widgets

PanelWindow {

    id: bar

    property string screenName

    Component.onCompleted: {
        bar.screenName = bar.screen.name
    }
    onScreenChanged: { 
        bar.screenName = bar.screen.name
    }

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
    }

    WorkspaceSwitcher {
        screenName: bar.screenName
    }
    Clock {}

    Row {
        spacing: 12;
        anchors {
            right: parent.right
            rightMargin: 12
        }

        ActiveServices {}

        // Taskbar {}
        Media {}
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
                onClicked: menu.open = !menu.open;
            }
        }

        Menu {
            id: menu
        }
    }
}
