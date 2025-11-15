import QtQuick
import Quickshell

import qs.Components

PopupWindow {
    anchor.window: toplevel
    anchor.rect.x: parentWindow.width / 2 - width / 2
    anchor.rect.y: parentWindow.height
    width: 500
    height: 500
    visible: true

    Container { // Background
        anchors.fill: parent

        indent: 10
    }
}