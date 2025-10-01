//@ pragma IconTheme Papirus-Dark

import QtQuick // for Text
import QtQuick.Controls
import Quickshell
import Quickshell.Io
import Quickshell.Widgets

PanelWindow {

    anchors {
        top: true
        left: true
        right: true
    }

    id: set

    readonly property string mainOutput: "DP-4"
    screen: (Quickshell.screens.find(s => s.name === mainOutput)) ?? Quickshell.screens[0]

    property var workspaces
    property int workspacesOnMainOutputCount
    property var windows
    readonly property string socketPath: Quickshell.env("NIRI_SOCKET")
    property bool overviewOpen: false

    Socket {
        id: eventStreamSocket
        path: set.socketPath
        connected: true

        onConnectionStateChanged: {
            if (connected) {
                write('"EventStream"\n')
            }
        }

        parser: SplitParser {
            onRead: line => {
                try {
                    const event = JSON.parse(line)
                    handleNiriEvent(event)
                } catch (e) {
                    console.warn("NiriService: Failed to parse event:", line, e)
                }
            }
        }
    }

    Socket {
        id: requestSocket
        path: set.socketPath
        connected: true
    }

    function handleNiriEvent(event) {
        const eventType = Object.keys(event)[0];
        
        switch (eventType) {
            case 'WorkspacesChanged':
                handleWorkspacesChanged(event.WorkspacesChanged);
                getCurrentWindows(0)
                break;
            case 'WorkspaceActivated':
                handleWorkspaceActivated(event.WorkspaceActivated);
                getCurrentWindows(0)
                break;
            case 'WorkspaceActiveWindowChanged':
                // handleWorkspaceActiveWindowChanged(event.WorkspaceActiveWindowChanged);
                // getCurrentWindows(0)
                break;
            case 'WindowsChanged':
                // handleWindowsChanged(event.WindowsChanged);
                getCurrentWindows(0)
                break;
            case 'WindowClosed':
                // handleWindowClosed(event.WindowClosed);
                getCurrentWindows(-1)
                break;
            case 'WindowOpenedOrChanged':
                // handleWindowOpenedOrChanged(event.WindowOpenedOrChanged);
                getCurrentWindows(0)
                break;
            case 'WindowLayoutsChanged':
                // handleWindowLayoutsChanged(event.WindowLayoutsChanged);
                getCurrentWindows(0)
                break;
            // case 'OutputsChanged':
            //     handleOutputsChanged(event.OutputsChanged);
            //     break;
            case 'OverviewOpenedOrClosed':
                handleOverviewChanged(event.OverviewOpenedOrClosed);
                break;
            // case 'ConfigLoaded':
            //     handleConfigLoaded(event.ConfigLoaded);
            //     break;
            // case 'KeyboardLayoutsChanged':
            //     handleKeyboardLayoutsChanged(event.KeyboardLayoutsChanged);
            //     break;
            // case 'KeyboardLayoutSwitched':
            //     handleKeyboardLayoutSwitched(event.KeyboardLayoutSwitched);
            //     break;
        }
    }

    function handleWorkspacesChanged(data) {
        currentWorkspaces.exec(currentWorkspaces.command)
        
    }

    function handleWorkspaceActivated(data) {
        currentWorkspaces.exec(currentWorkspaces.command)

    }

    function getCurrentWindows(offset) {
        currentWindows.exec(currentWindows.command)
    }

    function handleOverviewChanged(data) {
        set.overviewOpen = data.is_open
    }

    Process {
        id: currentWindows
        command: ["niri", "msg", "--json", "windows"]

        stdout: StdioCollector { waitForEnd: true }
        stderr: StdioCollector { waitForEnd: true }

        onExited: {
            set.windows = JSON.parse( stdout.text.trim() )
        }
    }

    Process {
        id: currentWorkspaces
        command: ["niri", "msg", "--json", "workspaces"]

        stdout: StdioCollector { waitForEnd: true }
        stderr: StdioCollector { waitForEnd: true }

        onExited: {
            set.workspaces = JSON.parse( stdout.text.trim() )
        }
    }


    implicitHeight: 30

    color: "transparent"

    Item {
        visible: set.windowsOnCurrentWorkspace || overviewOpen
        anchors.fill: parent

        anchors.leftMargin: 8
        anchors.rightMargin: 8

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

        Row {
            anchors.left: parent.left
            anchors.verticalCenter: parent.verticalCenter

            spacing: 10

            Workspaces {}
            Media {}

            anchors.leftMargin: 4
        }

        Timedate {}

        Row {
            anchors.right: parent.right
            anchors.verticalCenter: parent.verticalCenter

            spacing: 10

            Pipewire {}

            anchors.rightMargin: 4
        }

        PanelWindow {

            screen: set.screen

            anchors.right: true

            implicitWidth: 0
            implicitHeight: 0

            Item {
                id: widgetItem
                y: -278
            }

            // visible: !set.windowsOnCurrentWorkspace && !overviewOpen
            visible: false


            PopupWindow {
                visible: true
                implicitWidth: 1450
                implicitHeight: 556

                anchor {
                    item: widgetItem
                }

                color: "transparent"

                Widgets {}
            }
        }
    }
}