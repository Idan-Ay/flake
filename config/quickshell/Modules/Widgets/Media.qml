import QtQuick
import Quickshell
import Quickshell.Services.Mpris

import qs.Components

Underline {

    SText {
        text: Mpris.players.values[0]?.trackTitle ?? "No track playing"
        elide: Text.ElideRight
        width: 280
        // text: Mpris.players.values[0].length
        anchors.verticalCenter: parent.verticalCenter
    }
    Row {
        anchors.right: parent.right
        Rectangle {
            height: bar.height - 4
            width: height
            color: "transparent"
            SText {
                anchors.centerIn: parent
                text: ""
            }
            MouseArea {
                anchors.fill: parent
                onClicked: Mpris.players.values[0]?.previous()
            }
        }
        Rectangle {
            height: bar.height - 4
            width: height
            color: "transparent"
            SText {
                anchors.centerIn: parent
                text: Mpris.players.values[0]?.isPlaying ? "" : ""
            }
            MouseArea {
                anchors.fill: parent
                onClicked: Mpris.players.values[0]?.togglePlaying() 
            }
        }
        Rectangle {
            height: bar.height - 4
            width: height
            color: "transparent"
            SText {
                anchors.centerIn: parent
                text: ""
            }
            MouseArea {
                anchors.fill: parent
                onClicked: Mpris.players.values[0]?.next()
                }
            }
        }
    }
