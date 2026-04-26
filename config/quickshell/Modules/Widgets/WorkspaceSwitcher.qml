import QtQuick
import Quickshell

import qs.Components
import qs.Services

Element {
        width: 150
        height: 23

        id: root

        property string screenName

        function getNiriWorkspaces() {
            if (NiriService.allWorkspaces.length === 0) {
                return [
                    {
                        "id": 1,
                        "idx": 0,
                        "name": ""
                    },
                    {
                        "id": 2,
                        "idx": 1,
                        "name": ""
                    }
                ];
            }

            const fallbackWorkspaces = [
                {
                    "id": 1,
                    "idx": 0,
                    "name": ""
                },
                {
                    "id": 2,
                    "idx": 1,
                    "name": ""
                }
            ];

            const displayWorkspaces = NiriService.allWorkspaces.filter(ws => ws.output === root.screenName);
            let workspaces = displayWorkspaces.length > 0 ? displayWorkspaces : fallbackWorkspaces;

            workspaces = workspaces.slice().sort((a, b) => a.idx - b.idx);

            return workspaces;
        }

        function getNiriActiveWorkspace() {
            if (NiriService.allWorkspaces.length === 0) {
                return 1;
            }

            const activeWs = NiriService.allWorkspaces.find(ws => ws.output === root.screenName && ws.is_active);
            return activeWs ? activeWs.idx : 1;
        }

        Row {
            spacing: 8

            anchors.centerIn: parent

            Repeater {

                model: getNiriWorkspaces()

                Rectangle {

                    width: getNiriActiveWorkspace() === index+1 ? 32 : 10
                    height: 5

                    radius: 100

                    // color: NiriService.selectedWorkspaceOnMainOutputIndex === index
                    //         ? Qt.rgba(1, 1, 1, 0.75)
                    //         : Qt.rgba(0.5, 0.5, 0.5, 0.75)

                    color: Qt.rgba(1, 1, 1, 0.75)

                    // Behavior on width {
                        // NumberAnimation { duration: 100; easing.type: Easing.OutQuad; }
                    // }
                }
            }
        }
    }
