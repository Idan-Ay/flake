import QtQuick
import Quickshell

Item {
    SystemClock {
            id: clock
            precision: SystemClock.Seconds
    }

    Container {

        width: 400
        height: 23

        anchors.horizontalCenter: parent.horizontalCenter

        bg: Qt.rgba(0.15, 0.15, 0.15, 0.75)

        Text {
            anchors.centerIn: parent

            text: Qt.formatDateTime(clock.date, "hh:mm : ddd, dd.MM.yyyy, MMMM")
            font.family: "JetBrainsMono Nerd Font"
            font.pixelSize: 14
            color: "white"
        }
    }
}