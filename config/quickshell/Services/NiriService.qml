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

    property var workspaces: ({})
    property var allWorkspaces: []
    property int focusedWorkspaceIndex: 0
    property string focusedWorkspaceId: ""
    property var currentOutputWorkspaces: []
    property string currentOutput: ""

    property var outputs: ({})
    property var windows: []

    property bool overviewOpen: false

    property bool focusedWorkspaceHasWindowsVar: false

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

    function sortWindowsByLayout(windowList) {
        const enriched = windowList.map(w => {
            const ws = workspaces[w.workspace_id];
            if (!ws) {
                return {
                    "window": w,
                    "outputX": 999999,
                    "outputY": 999999,
                    "wsIdx": 999999,
                    "col": 999999,
                    "row": 999999
                };
            }

            const outputInfo = outputs[ws.output];
            const outputX = (outputInfo && outputInfo.logical) ? outputInfo.logical.x : 999999;
            const outputY = (outputInfo && outputInfo.logical) ? outputInfo.logical.y : 999999;

            const pos = w.layout?.pos_in_scrolling_layout;
            const col = (pos && pos.length >= 2) ? pos[0] : 999999;
            const row = (pos && pos.length >= 2) ? pos[1] : 999999;

            return {
                "window": w,
                "outputX": outputX,
                "outputY": outputY,
                "wsIdx": ws.idx,
                "col": col,
                "row": row
            };
        });

        enriched.sort((a, b) => {
            if (a.outputX !== b.outputX)
                return a.outputX - b.outputX;
            if (a.outputY !== b.outputY)
                return a.outputY - b.outputY;
            if (a.wsIdx !== b.wsIdx)
                return a.wsIdx - b.wsIdx;
            if (a.col !== b.col)
                return a.col - b.col;
            if (a.row !== b.row)
                return a.row - b.row;
            return a.window.id - b.window.id;
        });

        return enriched.map(e => e.window);
    }

    function updateCurrentOutputWorkspaces() {
        if (!currentOutput) {
            currentOutputWorkspaces = allWorkspaces;
            return;
        }

        const outputWs = allWorkspaces.filter(w => w.output === currentOutput);
        currentOutputWorkspaces = outputWs;
    }


    function setWorkspaces(newMap) {
        root.workspaces = newMap;
        root.allWorkspaces = Object.values(newMap).sort((a, b) => a.idx - b.idx);
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
            case 'WindowsChanged':
                handleWindowsChanged(event.WindowsChanged);
                break;
            case 'WindowClosed':
                handleWindowClosed(event.WindowClosed);
                break;
            case 'WindowOpenedOrChanged':
                handleWindowOpenedOrChanged(event.WindowOpenedOrChanged);
                break;
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

    function handleWindowsChanged(data) {
        windows = sortWindowsByLayout(data.windows);
    }

    function handleWindowClosed(data) {
        windows = windows.filter(w => w.id !== data.id);
        // selectedWorkspaceHasWindows()
    }

    function handleWindowOpenedOrChanged(data) {
        if (!data.window)
            return;
        const window = data.window;
        const existingIndex = windows.findIndex(w => w.id === window.id);

        if (existingIndex >= 0) {
            const updatedWindows = [...windows];
            updatedWindows[existingIndex] = window;
            windows = sortWindowsByLayout(updatedWindows);
        } else {
            windows = sortWindowsByLayout([...windows, window]);
        }
        // selectedWorkspaceHasWindows()
    }


    function handleWorkspacesChanged(data) {
        const newWorkspaces = {};

        for (const ws of data.workspaces) {
            const oldWs = root.workspaces[ws.id];
            newWorkspaces[ws.id] = ws;
            if (oldWs && oldWs.active_window_id !== undefined) {
                newWorkspaces[ws.id].active_window_id = oldWs.active_window_id;
            }
        }

        setWorkspaces(newWorkspaces);

        focusedWorkspaceIndex = allWorkspaces.findIndex(w => w.is_focused);
        if (focusedWorkspaceIndex >= 0) {
            const focusedWs = allWorkspaces[focusedWorkspaceIndex];
            focusedWorkspaceId = focusedWs.id;
            currentOutput = focusedWs.output || "";
        } else {
            focusedWorkspaceIndex = 0;
            focusedWorkspaceId = "";
        }

        updateCurrentOutputWorkspaces();
    }

    function handleWorkspaceActivated(data) {
        const ws = root.workspaces[data.id];
        if (!ws) {
            return;
        }
        const output = ws.output;

        const updatedWorkspaces = {};

        for (const id in root.workspaces) {
            const workspace = root.workspaces[id];
            const got_activated = workspace.id === data.id;

            const updatedWs = {};
            for (let prop in workspace) {
                updatedWs[prop] = workspace[prop];
            }

            if (workspace.output === output) {
                updatedWs.is_active = got_activated;
            }

            if (data.focused) {
                updatedWs.is_focused = got_activated;
            }

            updatedWorkspaces[id] = updatedWs;
        }

        setWorkspaces(updatedWorkspaces);

        focusedWorkspaceId = data.id;
        focusedWorkspaceIndex = allWorkspaces.findIndex(w => w.id === data.id);

        if (focusedWorkspaceIndex >= 0) {
            currentOutput = allWorkspaces[focusedWorkspaceIndex].output || "";
        }

        updateCurrentOutputWorkspaces();
        // selectedWorkspaceHasWindows()
    }

    function handleWindowFocusChanged(data) {
        const focusedWindowId = data.id;

        let focusedWindow = null;
        const updatedWindows = [];

        for (var i = 0; i < windows.length; i++) {
            const w = windows[i];
            const updatedWindow = {};

            for (let prop in w) {
                updatedWindow[prop] = w[prop];
            }

            updatedWindow.is_focused = (w.id === focusedWindowId);
            if (updatedWindow.is_focused) {
                focusedWindow = updatedWindow;
            }

            updatedWindows.push(updatedWindow);
        }

        windows = updatedWindows;

        if (focusedWindow) {
            const ws = root.workspaces[focusedWindow.workspace_id];
            if (ws && ws.active_window_id !== focusedWindowId) {
                const updatedWs = {};
                for (let prop in ws) {
                    updatedWs[prop] = ws[prop];
                }
                updatedWs.active_window_id = focusedWindowId;

                const updatedWorkspaces = {};
                for (const id in root.workspaces) {
                    updatedWorkspaces[id] = id === focusedWindow.workspace_id ? updatedWs : root.workspaces[id];
                }
                setWorkspaces(updatedWorkspaces);
            }
        }
    }

    function handleWorkspaceActiveWindowChanged(data) {
        const ws = root.workspaces[data.workspace_id];
        if (ws) {
            const updatedWs = {};
            for (let prop in ws) {
                updatedWs[prop] = ws[prop];
            }
            updatedWs.active_window_id = data.active_window_id;

            const updatedWorkspaces = {};
            for (const id in root.workspaces) {
                updatedWorkspaces[id] = id === data.workspace_id ? updatedWs : root.workspaces[id];
            }
            setWorkspaces(updatedWorkspaces);
        }

        const updatedWindows = [];

        for (var i = 0; i < windows.length; i++) {
            const w = windows[i];
            const updatedWindow = {};

            for (let prop in w) {
                updatedWindow[prop] = w[prop];
            }

            if (data.active_window_id !== null && data.active_window_id !== undefined) {
                updatedWindow.is_focused = (w.id == data.active_window_id);
            } else {
                updatedWindow.is_focused = w.workspace_id == data.workspace_id ? false : w.is_focused;
            }

            updatedWindows.push(updatedWindow);
        }

        windows = updatedWindows;
    }

    function handleOverviewChanged(data) {
        overviewOpen = data.is_open
    }
}
