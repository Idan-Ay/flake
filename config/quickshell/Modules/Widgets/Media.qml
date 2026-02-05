import QtQuick
import Quickshell
import Quickshell.Services.Mpris

import qs.Components

Rectangle {
            width: 360
            height: bar.height - 4

            color: "transparent"

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

            Rectangle {
                width: parent.width
                height: 1
                anchors.bottom: parent.bottom
            }
        }
