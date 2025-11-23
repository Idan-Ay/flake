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

            Repeater {
                // modelt 
                Rectangle {
                    width: 500 - 32
                    height: 20
                    color: "transparent"

                    SSlider {
                        width: 500 - 32 - 6
                        height: 20
                    }
                }
            } 
        }
    }
}