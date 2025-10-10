// pragma Singleton
// pragma ComponentBehavior: Bound

// import QtQuick
// import Quickshell
// import Quickshell.Io
// import qs.Common

// Singleton {
//     id: root

//     property bool getRandomWallpaperOnStatup: true
//     property bool getBlurredWallpaperOnCover: true

//     function getRandomWallpaper() {
//         const dir = SessoinData.wallpaperPath
//         const randomWallpaper = dir[0]
//         SessionData.setWallpaper(randomWallpaper)
//     }

//     function switchToBlurWallpaper() {
//         const dir = SessionData.wallpaperPath
//         SessionData.setWallpaper(p+"blurred/"+dir[0])
//     }

//     IpcHandler {
//         target: blur
//         function callS(): void {switchToBlurWallpaper()}
//     }
// }

// SessionData.setMonitorWallpaper(prevCyclingProcess.targetScreenName, prevWallpaper)
// return CompositorService.filterCurrentWorkspace(CompositorService.sortedToplevels, parentScreen.name);

// property int currentWorkspace: {
//     if (CompositorService.isNiri) {
//         return getNiriActiveWorkspace()
//     } else if (CompositorService.isHyprland) {
//         return getHyprlandActiveWorkspace()
//     }
//     return 1
// }
// property var workspaceList: {
//     if (CompositorService.isNiri) {
//         const baseList = getNiriWorkspaces()
//         return SettingsData.showWorkspacePadding ? padWorkspaces(baseList) : baseList
//     }
//     if (CompositorService.isHyprland) {
//         const baseList = getHyprlandWorkspaces()
//         return SettingsData.showWorkspacePadding ? padWorkspaces(baseList) : baseList
//     }
//     return [1]
// }


// function getNiriWorkspaces() {
//     if (NiriService.allWorkspaces.length === 0) {
//         return [1, 2]
//     }

//     if (!root.screenName || !SettingsData.workspacesPerMonitor) {
//         return NiriService.getCurrentOutputWorkspaceNumbers()
//     }

//     const displayWorkspaces = NiriService.allWorkspaces.filter(ws => ws.output === root.screenName).map(ws => ws.idx + 1)
//     return displayWorkspaces.length > 0 ? displayWorkspaces : [1, 2]
// }

// function getNiriActiveWorkspace() {
//     if (NiriService.allWorkspaces.length === 0) {
//         return 1
//     }

//     if (!root.screenName || !SettingsData.workspacesPerMonitor) {
//         return NiriService.getCurrentWorkspaceNumber()
//     }

//     const activeWs = NiriService.allWorkspaces.find(ws => ws.output === root.screenName && ws.is_active)
//     return activeWs ? activeWs.idx + 1 : 1
// }