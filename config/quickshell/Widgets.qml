import QtQuick
import Quickshell

Row {

    Timer {
        interval: 1000
        running: true
        repeat: true
        onTriggered: {
            time.text = Qt.formatDateTime(new Date(), "hh:mm")
            date.text = Qt.formatDateTime(new Date(), "ddd, dd.MM.yyyy")
        }
    }

    Container {
        height: 160
        width: 320
        
        Rectangle {
            anchors.centerIn: parent
            width: 260
            height: 80

            color: "transparent"

            Column {
                Text {
                    id: time
                    text: Qt.formatDateTime(new Date(), "hh:mm")
                    color: "white"
                    font.pixelSize: 42
                    font.bold: true
                }
                Text {
                    id: date
                    text: Qt.formatDateTime(new Date(), "ddd, dd.MM.yyyy")
                    color: "white"
                    font.pixelSize: 22
                }
            }
        }
    }

    Container {
        height: 160
        width: height
        
        Text {
            anchors.centerIn: parent
            text: ""
            color: "white"
            font.pixelSize: 42
        }
    }

    Container {
        height: 160
        width: height
        
        Text {
            anchors.centerIn: parent
            text: "󰜉"
            color: "white"
            font.pixelSize: 52
        }
    }

    Container {
        height: 160
        width: 320

        Image {
            source: "profile.png"
            width: 60
            height: width
            radius: 100
        }

        Text {
            text: (Quickshell.env("USER") || "unknown")
                + "@"
                + (Quickshell.env("HOSTNAME") || "unknown")
        }
    }
}