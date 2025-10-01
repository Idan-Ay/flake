import QtQuick
import Quickshell

Box {

    id: root

    width: 100
    Row {
        anchors.centerIn: parent
        spacing: 6
        Repeater {
            model: workspacesMainOutputCount

            Rectangle {
                color: "white"
                width: index === set.focusedWorkspaceIndex ? 32 : 5
                height: 5
                // border.color: "white"
                // border.width: 2
                radius: 100

                Behavior on width { NumberAnimation { duration: 150; easing.type: Easing.InOutQuad } }
            }
        }
    }
}