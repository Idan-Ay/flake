import QtQuick
import Quickshell
import Quickshell.Services.Mpris

Box {
    id: media

    anchors.verticalCenter: parent.verticalCenter

    readonly property MprisPlayer activePlayer: MprisController.activePlayer
    readonly property bool playerAvailable: activePlayer !== null

    Row {
        spacing: 6

        // Previous
        Rectangle {
            width: 22
            height: width
            Text {
                text: "Previous"
            }
            MouseArea {
                anchors.fill: parent
                onClicked: activePlayer.previous()
            }
        }

        // Play/Pause
        Rectangle {
            width: 22
            height: width
            Text {
                // text: Mpris.PlaybackState === "Playing" ? "Pause" : "Continue"
            }
            MouseArea {
                anchors.fill: parent
                onClicked: activePlayer.togglePlaying()
            }
        }

        // Next
        Rectangle {
            width: 22
            height: width
            Text {
                text: "Next"
            }
            MouseArea {
                anchors.fill: parent
                onClicked: activePlayer.next()
            }
        }
    }

}