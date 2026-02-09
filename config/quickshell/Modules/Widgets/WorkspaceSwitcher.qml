import QtQuick
import Quickshell

import qs.Components
import qs.Services

Element {
        width: 150
        height: 23

        id: root

        property string screenName

        property int numWorkspaces
        property int selectedWorkspaceIndex

        Connections {
            target: NiriService
            onUpdated: {
                numWorkspaces = NiriService.workspacesPerOutput[root.screenName]
                selectedWorkspaceIndex = NiriService.selectedWorkspacePerOutputIndex[root.screenName]
            }
        }


        Row {
            spacing: 8

            anchors.centerIn: parent

            Repeater {

                model: root.numWorkspaces

                Rectangle {

                    width: root.selectedWorkspaceIndex === index ? 32 : 10
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
