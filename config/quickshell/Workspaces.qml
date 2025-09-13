import QtQuick
import QtQuick.Controls
import Quickshell
import Quickshell.Widgets
import Quickshell.Hyprland

Box {

    width: 150

    Repeater {
        model: getNiriWorkspaces().length
        Rectangle {
            color: "Transparent"
            width: 10
            height: 10
            border.color: "white"
            border.width: 2
        }
    }
}