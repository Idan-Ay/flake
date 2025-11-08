import QtQuick
import Quickshell

import qs.Components
import qs.Modules.Widgets

PanelWindow {

    id: bar

    anchors {
        top: true
        left: true
        right: true
    }

    implicitHeight: 27

    color: "transparent"

    Container { // Background
        width: bar.width - 8
        height: bar.height
    }

    // Context Menu
    Container {
        width: 400
        height: 23
        
        bg: Qt.rgba(0.15, 0.15, 0.15, 0.75)
    }

    WorkspaceSwitcher {}
    Clock {}
}