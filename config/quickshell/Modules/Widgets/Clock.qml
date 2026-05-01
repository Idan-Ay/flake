import QtQuick
import Quickshell

import qs.Components


Element {

    SystemClock {
        id: clock
        precision: SystemClock.Seconds
    }

    width: 400
    height: 23

    anchors.horizontalCenter: parent.horizontalCenter

    SText {
        text: Qt.formatDateTime(clock.date, "ddd - hh:mm - dd.MM")
        anchors.centerIn: parent
    }
}
