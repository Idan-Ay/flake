import QtQuick
import Quickshell
import Quickshell.Services.Mpris

Box {
    id: media

    anchors.verticalCenter: parent.verticalCenter

    readonly property MprisPlayer activePlayer: MprisController.activePlayer
    readonly property bool playerAvailable: activePlayer !== null

    visible: activePlayer
    enabled: visible

    width: 380

    Row {
        spacing: 6

        anchors.centerIn: parent

        Text {
            text: activePlayer.trackTitle;
            color: "white"
            font.pixelSize: 14

            width: 270
            height: 16

            elide: Text.ElideRight

            anchors.verticalCenter: parent.verticalCenter
        }

        // Previous
        Rectangle {
            width: 20
            height: width
            radius: 100

            color: "transparent"

            Text {
                text: "󰒮"
                color: "white"
                anchors.centerIn: parent
                font.pixelSize: 18
            }
            MouseArea {
                anchors.fill: parent
                onClicked: activePlayer.previous()
            }
        }

        // Play/Pause
        Rectangle {
            width: 20
            height: width
            radius: 100

            color: "transparent"

            border.width: 2
            border.color: "#ffffff"

            anchors.verticalCenter: parent.verticalCenter

            Text {
                text: activePlayer && activePlayer.playbackState === 1 ? "󰏤" : "󰐊"
                color: "white"
                anchors.centerIn: parent
                font.pixelSize: 16
            }
            MouseArea {
                anchors.fill: parent
                onClicked: activePlayer.togglePlaying()
            }
        }

        // Next
        Rectangle {
            width: 20
            height: width
            radius: 100

            color: "transparent"

            Text {
                text: "󰒭"
                color: "white"
                anchors.centerIn: parent
                font.pixelSize: 18
            }
            MouseArea {
                anchors.fill: parent
                onClicked: activePlayer.next()
            }
        }
    }

}