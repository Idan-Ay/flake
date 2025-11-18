import QtQuick
import Quickshell

import qs.Components

PopupWindow {
    anchor.window: bar
    anchor.rect.x: parentWindow.width - width - 18
    anchor.rect.y: parentWindow.height
    implicitHeight: 500
    implicitWidth: 500
    visible: true

    color: "transparent"

    Container { // Background
        anchors.fill: parent
        indent: 10

        Container {
            anchors {
                rightMargin: 8
                leftMargin: 8
                topMargin: 8
            }


            bg: Qt.rgba(0.15, 0.15, 0.15, 0.75)
        }
    }
}