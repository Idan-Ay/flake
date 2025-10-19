pragma Singleton
pragma ComponentBehavior: Bound

import QtQuick
import Quickshell
import Quickshell.Io
import qs.Common

Singleton {

    id: root

    property bool getRandomWallpaperOnStatup: true
    property bool getBlurredWallpaperOnCover: true

    property var screens: Quickshell.screens

    property var allWallpapersBaseName
    property string basename

    property string parentPath: Quickshell.env("HOME") + "/.config/wallpapers"
    property string blurredPath: parentPath + "/blurred"

    property var blurredScreens: []

    property real lastUpdated

    Component.onCompleted: {
        getRandomWallpaper()
    }

    Connections {
        target: CompositorService
        function onSortedToplevelsChanged() { updateWallpaperBlurStateTimer.start() }
    }

    function getRandomWallpaper() {
        getAllWallpapers.exec(getAllWallpapers.command)
    }
    Process {
        id: getAllWallpapers
        command: ["bash", "-lc", 'ls -p "' + parentPath + '" | egrep -v /']

        stdout: StdioCollector { waitForEnd: true }
        stderr: StdioCollector { waitForEnd: true }

        onExited: {
            root.allWallpapersBaseName = stdout.text.trim().split(/\r?\n/)
            const randomWallpaper = 
                root.allWallpapersBaseName[
                    Math.floor(
                        Math.random() * root.allWallpapersBaseName.length
                    )
                ]
            root.basename = randomWallpaper
            for (const index in root.screens) {
                const screen = root.screens[index].name
                SessionData.setMonitorWallpaper( screen, root.parentPath + "/" + randomWallpaper )
            }
        }
    }

    Timer {
        id: updateWallpaperBlurStateTimer
        interval: 10
        repeat: false
        onTriggered: updateWallpaperBlurState()
    }

    function updateWallpaperBlurState() {

        for (const index in root.screens) {
            const screen = root.screens[index].name
            const filteredTopLevels = CompositorService.filterCurrentWorkspace(CompositorService.sortedToplevels, screen);

            const doBlur = !filteredTopLevels.length < 1 || NiriService.inOverview

            if (root.blurredScreens && root.blurredScreens[index] === doBlur) {
                continue
            }
            
            if (doBlur) {
                root.blurredScreens[index] = true
                switchToBlurWallpaper(screen)
            } else {
                root.blurredScreens[index] = false
                switchToDefaultWallpaper(screen)
            }
        }
    }

    function switchToBlurWallpaper(screen) {
        SessionData.setMonitorWallpaper( screen, root.blurredPath+"/"+root.basename )
    }
    function switchToDefaultWallpaper(screen) {
        SessionData.setMonitorWallpaper( screen, root.parentPath+"/"+root.basename )
    }

    ShellRoot {
        IpcHandler {
            target: "wallpaper-cycling"
            function random() { getRandomWallpaper() }
            function blurUpdate() { updateWallpaperBlurState() }
            function blur() { switchToBlurWallpaper("DP-4") }
            function unblur() { switchToDefaultWallpaper("DP-4") }
        }
    }
}