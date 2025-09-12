import Quickshell
import Quickshell.Io
import QtQuick


Rectangle {

    color: Qt.rgba(5, 5, 5, 0.05);
    radius: 6

    anchors.centerIn: parent

    width: 400
    height: 22

    Row { // Time & Date
        id: clock
        anchors.centerIn: parent
        spacing: 6

        Text {
            id: time
            text: Qt.formatDateTime(new Date(), "hh:mm")
            color: "white"
            font.pixelSize: 14
            font.bold: true
        }
        Rectangle {
            anchors.verticalCenter: parent.verticalCenter
            radius: 100
            width: 3
            height: width
        }
        Text {
            id: day
            text: Qt.formatDateTime(new Date(), "ddd")
            color: "white"
            font.pixelSize: 14
            font.bold: true
        }
        Rectangle {
            anchors.verticalCenter: parent.verticalCenter
            radius: 100
            width: 3
            height: width
        }
        Text {
            id: date
            text: Qt.formatDateTime(new Date(), "dd.MM.yyyy")
            color: "white"
            font.pixelSize: 14
            font.bold: true
        }
        

        Timer {
            interval: 1000
            running: true
            repeat: true
            onTriggered: {
                time.text = Qt.formatDateTime(new Date(), "hh:mm")
                day.text = Qt.formatDateTime(new Date(), "ddd")
                date.text = Qt.formatDateTime(new Date(), "dd.MM.yyyy")
            }
        }
    }
}
