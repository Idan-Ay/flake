import Quickshell // for PanelWindow
import QtQuick // for Text

PanelWindow {

    anchors {
        top: true
        left: true
        right: true
    }

    id: bar

    implicitHeight: 30

    color: "transparent"

    Item { // Background
        anchors.fill: parent

        anchors.leftMargin: 8
        anchors.rightMargin: 8

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

    Row {
        anchors.left: parent.left
        anchors.verticalCenter: parent.verticalCenter

        spacing: 10

        Workspaces {}
        Media {}

        anchors.leftMargin: 12
    }

    Timedate {}

    Row {
        anchors.right: parent.right
        anchors.verticalCenter: parent.verticalCenter

        spacing: 10

        Pipewire {}

        anchors.rightMargin: 12
    }

    PopupWindow {
        visible: true
        width: 412
        height: 312

        anchor.window: bar

        color: "transparent"

        Widgets {}
    }
}