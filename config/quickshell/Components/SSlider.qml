import QtQuick
import QtQuick.Controls
import Quickshell

import qs.Components


Slider {
    id: slider
    anchors.centerIn: parent
    width: parent.width * 0.95

    from: 0
    to: 1
    stepSize: 0.01
    value: 0.5
    live: true

    onValueChanged: {
        console.log("slider value:", value)
    }
}