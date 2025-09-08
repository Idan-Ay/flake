import Quickshell // for PanelWindow
import QtQuick // for Text
import Quickshell.Widgets
import Quickshell.Services.Pipewire
j
PanelWindow {
    anchors {
        top: true
        left: true
        right: true
    }

    implicitHeight: 30

    color: "transparent"

    Item { // Background
        anchors.fill: parent

        layer.enabled: true
        opacity: 0.75
        Rectangle {
            color: "Black"
            width: parent.width
            height: 14
        }
        Rectangle {
            anchors.fill: parent
            color: "Black"
            radius: 16
        }
    }

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

    PwObjectTracker {
        objects: [Pipewire.defaultAudioSink, Pipewire.defaultAudioSource]
    }

    Row {
        id: sound
        anchors.right: parent.right
        anchors.verticalCenter: parent.verticalCenter

        spacing: 16

        // Bind the node so audio.* properties are valid & reactive
        property var defaultAudioSink: Pipewire.defaultAudioSink
        property real volume: defaultAudioSink && defaultAudioSink.audio
            ? defaultAudioSink.audio.volume
            : 0
        property bool volumeMuted: defaultAudioSink && defaultAudioSink.audio
            ? defaultAudioSink.audio.muted
            : false

        property var defaultAudioSource: Pipewire.defaultAudioSource
            property bool inputMuted: defaultAudioSource && defaultAudioSource.audio
                ? defaultAudioSource.audio.muted
                : true

        Row {
            Rectangle {
                anchors.verticalCenter: parent.verticalCenter

                width: sound.inputMuted ? 34 : 30
                height: 30

                color: "transparent"
                Text {
                    text: !sound.inputMuted ? "" : " "

                    anchors.fill: parent
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter

                    font.pixelSize: 18
                    color: !sound.inputMuted ? "white" : "gray"
                }
            }
        }
        
        Row {
            spacing: 4
            Rectangle {
                anchors.verticalCenter: parent.verticalCenter
                width: 15
                height: 30
                color: "transparent"
                Text {
                    text: ""
                    color: sound.volume !== 0 ? "white" : "gray"
                    font.pixelSize: 22
                    font.bold: true
                }
            }
            Repeater {
                model: 10
                Rectangle {
                    anchors.verticalCenter: parent.verticalCenter
                    height: 14
                    width: 4
                    radius: 100
                    color: index+1 <= Math.round(sound.volume * 20) ? "white" : "gray"
                }
            }
            Rectangle {
                anchors.verticalCenter: parent.verticalCenter
                color: "transparent"
                width: 42
                height: 14
                Text {
                    anchors.centerIn: parent
                    color: "white"
                    font.pixelSize: 14
                    font.bold: true

                    text: !sound.volumeMuted ? Math.round(sound.volume * 100) + "%" : "---"
                }
            }
            Repeater {
                model: 10
                Rectangle {
                    anchors.verticalCenter: parent.verticalCenter
                    height: 14
                    width: 4
                    radius: 100
                    color: index+11 <= Math.round(sound.volume * 20) ? "white" : "gray"
                }
            }
        }
    }

    
    // Row {
    //     anchors.centerIn: parent
    //     spacing: 6

    //     Repeater {
    //         model: ToplevelManager.toplevels

    //         delegate: Item {
    //             required property Toplevel modelData
    //             readonly property bool active: modelData.activated

    //             // Animate the icon "badge" getting larger when active
    //             width:  active ? 50 : 28
    //             height: 28
    //             Behavior on width { NumberAnimation { duration: 150; easing.type: Easing.InOutQuad } }

    //             // Border "badge" behind the icon
    //             Rectangle {
    //                 anchors.fill: parent
    //                 radius: 100
    //                 color: "transparent"
    //                 border.width: active ? 2 : 0
    //                 border.color: active ? "#ffffff" : "transparent"
    //                 antialiasing: true

    //                 Behavior on border.width { NumberAnimation { duration: 120; easing.type: Easing.OutQuad } }
    //                 Behavior on border.color { ColorAnimation { duration: 120; easing.type: Easing.OutQuad } }
    //             }

    //             // The icon itself
    //             IconImage {
    //                 anchors.centerIn: parent
    //                 // Leave a little padding so the border is visible
    //                 width: 20
    //                 height: width

    //                 readonly property var entry: DesktopEntries.heuristicLookup(modelData.appId)
    //                 readonly property string iconName: entry ? entry.icon : modelData.appId
    //                 source: iconName.startsWith("/") ? iconName : Quickshell.iconPath(iconName, true)
    //             }

    //             MouseArea {
    //                 anchors.fill: parent
    //                 onClicked: modelData.activate()
    //             }
    //         }
    //     }
    // }
}