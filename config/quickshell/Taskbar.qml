import Quickshell
import Quickshell.Io
import QtQuick
import Quickshell.Widgets
import Quickshell.Wayland
import QtQuick.Effects

Row {
    spacing: 6

    anchors.verticalCenter: parent.verticalCenter

    Repeater {
        model: ToplevelManager.toplevels

        delegate: Item {
            required property Toplevel modelData
            readonly property bool active: modelData.activated

            // Animate the icon "badge" getting larger when active
            width:  active ? 62 : 42
            height: 22
            Behavior on width { NumberAnimation { duration: 150; easing.type: Easing.InOutQuad } }

            // Border "badge" behind the icon
            Rectangle {
                anchors.fill: parent
                radius: 6
                color: Qt.rgba(5, 5, 5, 0.05);
                border.width: active ? 2 : 0
                border.color: active ? "#ffffff" : "transparent"
                antialiasing: true

                Behavior on border.width { NumberAnimation { duration: 120; easing.type: Easing.OutQuad } }
                Behavior on border.color { ColorAnimation { duration: 120; easing.type: Easing.OutQuad } }
            }

            // The icon itself
            IconImage {
                id: appIcon
                anchors.centerIn: parent
                // Leave a little padding so the border is visible
                width: 18
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