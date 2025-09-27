//@ pragma IconTheme Papirus-Dark

import Quickshell // for PanelWindow
import QtQuick // for Text
import Quickshell.Io
import Quickshell.Wayland

PanelWindow {


    anchors {
        top: true
        left: true
        right: true
    }

    id: set

    property bool anyWindowsOpen: ToplevelManager.toplevels.count > 0

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

    PanelWindow {

        anchors.right: true

        implicitWidth: 0
        implicitHeight: 0

        Item {
            id: widgetItem
            y: -278
        }

        visible: set.anyWindowsOpen


        PopupWindow {
            visible: true
            implicitWidth: 1450
            implicitHeight: 556

            anchor {
                item: widgetItem
            }

            color: "transparent"

            Widgets {}
        }
    }
}