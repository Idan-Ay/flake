import QtCore
import QtQuick
import Quickshell
import Quickshell.Io
import Quickshell.Wayland

pragma Singleton

pragma ComponentBehavior

Singleton {
    id: root

    readonly property string socketPath: Quickshell.env("NIRI_SOCKET")

    property var windows: {[]}
    property var sortedWindows
    property var workspaces: {[]}
    property var workspacesPerOutput
    property var selectedWorkspacePerOutputId
    property var selectedWorkspacePerOutputIndex
    property bool overviewOpen: false

    signal updated()

    // Read event stream
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

    // Filter events & call functions
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
            // case 'WindowClosed':
                // handleWindowClosed();
                // break;
            // case 'WindowOpenedOrChanged':
                // getWindows.exec()
                // handleWindowOpenedOrChanged(event.WindowOpenedOrChanged);
                // break;
            // case 'WindowLayoutsChanged':
            //     handleWindowLayoutsChanged(event.WindowLayoutsChanged);
            //     break;
            // case 'OutputsChanged':
                // handleOutputsChanged(event.OutputsChanged);
                // console.log("test2")
                // break;
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

    // Search all elements in list
    // if on main output add 1 to workspacesOnMainOutputLength
    function handleWorkspacesChanged(data) {
        root.workspaces = data.workspaces
        root.workspacesPerOutput = {}
        for (const workspace of data.workspaces) {
            if (root.workspacesPerOutput[workspace.output]) {
                root.workspacesPerOutput[workspace.output]++
            } else {
                root.workspacesPerOutput[workspace.output] = 1
            }
        }
        root.updated()
    }

    // Search for object with id === selected id
    // Check if on main output
    // Assign index
    function handleWorkspaceActivated(data) {
        root.selectedWorkspacePerOutputIndex = {}
        root.selectedWorkspacePerOutputId = {}
        for (const workspace of root.workspaces) {
            if (workspace.id === data.id) {
                console.log(workspace.idx)
                root.selectedWorkspacePerOutputIndex[workspace.output] = workspace.idx - 1
                root.selectedWorkspacePerOutputId[workspace.output] = workspace.id
            }
        }
        root.updated()
    }

    function handleOverviewChanged(data) {
        overviewOpen = data.is_open
    }
}
