import QtQuick
import Quickshell

import qs.Components
import qs.Services
import qs.Modules.Widgets


PopupWindow {
    enabled: true
    anchors {
        top: parent.top
        topMargin: 20
    }
    implicitHeight: 30
    implicitWidth: 120
    color: Qt.rgba(0,0,0,0.75)
    border {
        color: "white"
        width: 1
    }
}
