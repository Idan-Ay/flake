import Quickshell
import Quickshell.Io
import QtQuick
import Quickshell.Widgets
import Quickshell.Wayland
import QtQuick.Effects

import qs.Components

Rectangle {
    color: "transparent"
    
    width: taskRow.width
    height: 26
   
    Row {
        spacing: 6
        
        id: taskRow

        Repeater {
            model: ToplevelManager.toplevels

            delegate: Item {
                required property Toplevel modelData
                readonly property bool active: modelData.activated

                // Animate the icon "badge" getting larger when active
                width: 32
                height: 26
                Behavior on width { NumberAnimation { duration: 150; easing.type: Easing.InOutQuad } }

                Rectangle {
                    visible: active
                    width: 5
                    height: 2

                    anchors {
                        top: parent.top
                        horizontalCenter: parent.horizontalCenter
                    }
                }

                IconImage {
                    id: appIcon
                    anchors.centerIn: parent
                    width: 16
                    height: width

                    readonly property var entry: DesktopEntries.heuristicLookup(modelData.appId)
                    readonly property string iconName: entry ? entry.icon : modelData.appId
                    source: iconName.startsWith("/") ? iconName : Quickshell.iconPath(iconName, true)
                }

                MultiEffect {
                    anchors.fill: appIcon
                    source: appIcon
                    saturation: -1.0
                    brightness: 0.2
                }

                MouseArea {
                    anchors.fill: parent
                    onClicked: modelData.activate()
                }
            }
        }
    }
}