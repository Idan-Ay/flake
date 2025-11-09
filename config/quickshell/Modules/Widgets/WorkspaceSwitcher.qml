import QtQuick
import Quickshell

import qs.Components
import qs.Services

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

                model: NiriService.workspaces.length

                Rectangle {

                    width: NiriService.focusedWorkspaceIndex === Index ? 36 : 12
                    height: 12

                    color: Qt.rgba(1, 1, 1, 0.75)
                }
            }
        }
    }