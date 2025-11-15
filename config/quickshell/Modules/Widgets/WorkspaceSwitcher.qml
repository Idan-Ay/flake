import QtQuick
import Quickshell

import qs.Components
import qs.Services

Container {
        width: 150
        height: 23

        bg: Qt.rgba(0.15, 0.15, 0.15, 0.75)

        Row {
            spacing: 10

            anchors.centerIn: parent

            Repeater {

                model: NiriService.workspacesOnMainOutputLength

                Rectangle {

                    width: NiriService.selectedWorkspaceOnMainOutputIndex === index ? 36 : 12
                    height: 12

                    color: NiriService.selectedWorkspaceOnMainOutputIndex === index
                            ? Qt.rgba(1, 1, 1, 0.75)
                            : Qt.rgba(0.5, 0.5, 0.5, 0.75)
                    
                    Behavior on width {
                        NumberAnimation { duration: 100; easing.type: Easing.OutQuad; }
                    }
                }
            }
        }
    }