import QtQuick
import Quickshell
import Quickshell.Services.Mpris

Rectangle {
    id: media

    color: Qt.rgba(5, 5, 5, 0.05);
    radius: 6

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
        }

        // Play/Pause
        Rectangle {
            width: 22
            height: width
            Text {
                // text: Mpris.PlaybackState === "Playing" ? "Pause" : "Continue"
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
                onClicked: activePlayer.togglePlaying()
            }
        }
    }

}