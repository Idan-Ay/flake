import QtQuick
import QtQuick.Controls
import Quickshell
import Quickshell.Io
import Quickshell.Widgets
import Quickshell.Hyprland

Box {

    id: root

    readonly property string mainOutput: "DP-4"

    property var workspaces: ({})
    property var windows
    readonly property string socketPath: Quickshell.env("NIRI_SOCKET")
    property int focusedWorkspaceIndex: 0
    property int focusedWorkspaceId
    property int workspacesMainOutputCount: 2

    width: 100
    Row {
        anchors.centerIn: parent
        spacing: 6
        Repeater {
            model: workspacesMainOutputCount

            Rectangle {
                color: "white"
                width: index === root.focusedWorkspaceIndex ? 32 : 5
                height: 5
                // border.color: "white"
                // border.width: 2
                radius: 100

                Behavior on width { NumberAnimation { duration: 150; easing.type: Easing.InOutQuad } }
            }
        }
    }

    Socket {
        id: eventStreamSocket
        path: root.socketPath
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
        path: root.socketPath
        connected: true
    }

    function handleNiriEvent(event) {
        const eventType = Object.keys(event)[0];
        
        switch (eventType) {
            case 'WorkspacesChanged':
                handleWorkspacesChanged(event.WorkspacesChanged);
                break;
            case 'WorkspaceActivated':
                handleWorkspaceActivated(event.WorkspaceActivated);
                break;
            // case 'WorkspaceActiveWindowChanged':
            //     handleWorkspaceActiveWindowChanged(event.WorkspaceActiveWindowChanged);
            //     break;
            // case 'WindowsChanged':
            //     handleWindowsChanged(event.WindowsChanged);
            //     break;
            case 'WindowClosed':
                handleWindowClosed();
                break;
            // case 'WindowOpenedOrChanged':
            //     handleWindowOpenedOrChanged(event.WindowOpenedOrChanged);
            //     break;
            // case 'WindowLayoutsChanged':
            //     handleWindowLayoutsChanged(event.WindowLayoutsChanged);
            //     break;
            // case 'OutputsChanged':
            //     handleOutputsChanged(event.OutputsChanged);
            //     break;
            // case 'OverviewOpenedOrClosed':
            //     handleOverviewChanged(event.OverviewOpenedOrClosed);
            //     break;
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
        // root.workspaces = data.workspaces

        const workspaces = {}
        let workspacesMainOutputCount_S = 0
        for (const ws of data.workspaces) {
            workspaces[ws.id] = ws
            if (ws.output === root.mainOutput) {
                workspacesMainOutputCount_S++
            }
        }
        
        root.workspacesMainOutputCount = workspacesMainOutputCount_S
        root.workspaces = workspaces
    }

    function handleWorkspaceActivated(data) {
        let focusedWorkspaceIndex = 0
        
        for (const id in root.workspaces) {
            if (root.workspaces[id] && root.workspaces[id].output === root.mainOutput) {

                if (root.workspaces[id].id === data.id) {
                    root.focusedWorkspaceIndex = focusedWorkspaceIndex
                    root.focusedWorkspaceId = data.id
                    return
                }

                focusedWorkspaceIndex++
            }
        }
    }

    function handleWindowClosed() {
        currentWindows.exec(currentWindows.command)
        for (const index in root.windows) {
            const window = root.window[index]
            if (window.workspace_id === root.focusedWorkspaceId) {
                return
            }
        }
        root.workspacesMainOutputCount--
    }

    Process {
        id: currentWindows
        command: ["niri", "msg", "--json", "windows"]

        stdout: StdioCollector { waitForEnd: true }
        stderr: StdioCollector { waitForEnd: true }

        onExited: {
            root.windows = JSON.parse( stdout.text.trim() )
        }
    }
}