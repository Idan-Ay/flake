import QtQuick
import Quickshell

import qs.Components
import qs.Services

Element {
        width: 150
        height: 23

        Row {
            spacing: 8

            anchors.centerIn: parent

            Repeater {

                model: NiriService.workspacesOnMainOutputLength

                Rectangle {

                    width: NiriService.selectedWorkspaceOnMainOutputIndex === index ? 32 : 10
                    height: 5

                    radius: 100

                    // color: NiriService.selectedWorkspaceOnMainOutputIndex === index
                    //         ? Qt.rgba(1, 1, 1, 0.75)
                    //         : Qt.rgba(0.5, 0.5, 0.5, 0.75)

                    color: Qt.rgba(1, 1, 1, 0.75)
                    
                    Behavior on width {
                        NumberAnimation { duration: 100; easing.type: Easing.OutQuad; }
                    }
                }
            }
        }
    }
