import Quickshell // for PanelWindow
import QtQuick // for Text
import Quickshell.Widgets
import Quickshell.Services.Pipewire

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
            height: 12
        }
        Rectangle {
            anchors.fill: parent
            color: "Black"
            radius: 8
        }
    }

    Timedate {}
    Pipewire {}

    
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