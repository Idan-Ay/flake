import Quickshell // for PanelWindow
import QtQuick // for Text

PanelWindow {
    anchors {
        top: true
        left: true
        right: true
    }

    implicitHeight: 30

    color: "transparent"

    Item { // Background
        anchors.fill: parent

        layer.enabled: true
        opacity: 0.75
        Rectangle {
            color: "Black"
            width: parent.width
            height: 12
        }
        Rectangle {
            anchors.fill: parent
            color: "Black"
            radius: 8
        }
    }

    Timedate {}

    Row {
        anchors.right: parent.right
        anchors.verticalCenter: parent.verticalCenter

        Pipewire {}
        Taskbar {}
    }
}