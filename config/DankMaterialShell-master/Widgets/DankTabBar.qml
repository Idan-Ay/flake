import QtQuick
import qs.Common
import qs.Widgets

Item {
    id: tabBar

    property alias model: tabRepeater.model
    property int currentIndex: 0
    property int spacing: Theme.spacingL
    property int tabHeight: 56
    property bool showIcons: true
    property bool equalWidthTabs: true

    property bool animationEnabled: false

    signal tabClicked(int index)
    signal actionTriggered(int index)

    height: tabHeight

    Row {
        id: tabRow
        anchors.fill: parent
        spacing: tabBar.spacing

        Repeater {
            id: tabRepeater

            Item {
                id: tabItem
                property bool isAction: modelData && modelData.isAction === true
                property bool isActive: !isAction && tabBar.currentIndex === index
                property bool hasIcon: tabBar.showIcons && modelData && modelData.icon && modelData.icon.length > 0
                property bool hasText: modelData && modelData.text && modelData.text.length > 0

                width: tabBar.equalWidthTabs ? (tabBar.width - tabBar.spacing * Math.max(0, tabRepeater.count - 1)) / Math.max(1, tabRepeater.count) : Math.max(contentCol.implicitWidth + Theme.spacingXL, 64)
                height: tabBar.tabHeight

                Column {
                    id: contentCol
                    anchors.centerIn: parent
                    spacing: Theme.spacingXS

                    DankIcon {
                        name: modelData.icon || ""
                        anchors.horizontalCenter: parent.horizontalCenter
                        size: 35
                        color: tabItem.isActive ? Theme.primary : Theme.surfaceText
                        visible: hasIcon
                    }
                }

                Rectangle {
                    id: stateLayer
                    anchors.fill: parent
                    color: Theme.surfaceTint
                    opacity: tabArea.pressed ? 0.12 : (tabArea.containsMouse ? 0.08 : 0)
                    visible: opacity > 0
                    radius: Theme.cornerRadius
                    Behavior on opacity { NumberAnimation { duration: Theme.shortDuration; easing.type: Theme.standardEasing } }
                }

                MouseArea {
                    id: tabArea
                    anchors.fill: parent
                    hoverEnabled: true
                    cursorShape: Qt.PointingHandCursor
                    onClicked: {
                        if (tabItem.isAction) {
                            tabBar.actionTriggered(index)
                        } else {
                            tabBar.currentIndex = index
                            tabBar.tabClicked(index)
                        }
                    }
                }

                Rectangle {
                    height: 5
                    width: isActive & tabBar.animationEnabled ? 50 : height
                    color: Theme.primary
                    radius: 100
                    anchors {
                        horizontalCenter: parent.horizontalCenter
                        bottom: parent.bottom
                    }

                    Behavior on width {
                        enabled: tabBar.animationEnabled
                        NumberAnimation {
                            duration: Theme.mediumDuration
                            easing.type: Theme.standardEasing
                        }
                    }
                }
            }
        }
    }

    onWidthChanged: Qt.callLater(() => tabBar.animationEnabled = true)
}