import QtQuick
import Quickshell

Container {
        width: 150
        height: 23

        // anchors {
        //     right: parent.right
        //     rightMargin: 12
        // }

        bg: Qt.rgba(0.15, 0.15, 0.15, 0.75)

        Row {
            spacing: 12

            anchors.centerIn: parent

            Repeater {

                model: 3

                Rectangle {

                    width: 12
                    height: 12

                    color: Qt.rgba(1, 1, 1, 0.75)
                }
            }
        }
    }