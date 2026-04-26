import QtQuick
import QtCore
import Quickshell
import Quickshell.Io
import Qt.labs.folderlistmodel
import Quickshell.Wayland
import QtQuick.Effects
import QtQuick.Shapes

import qs.Services

Item {
    id: root

    readonly property string configDir: StandardPaths.writableLocation(
        StandardPaths.ConfigLocation
    )

    FolderListModel {
        id: imagesModel
        folder: configDir + "/wallpapers"
        nameFilters: ["*.mp4" ]
        showDirs: false
        showHidden: false
    }

    property string randomWallpaper

    function getRandomWallpaper() {
        if (randomWallpaper) {
            return randomWallpaper
        }
        let index = Math.floor(Math.random() * imagesModel.count)
        randomWallpaper = imagesModel.get(index, "fileUrl")
        return randomWallpaper
    }
    property string imageWallpaper: "/tmp/image-for-wallpaper.png"

    Process {
        command: [
            "ffmpeg",
            "-i", getRandomWallpaper(),
            "-vf", "select=eq(n\\,0)",
            "-vframes", "1",
            imageWallpaper
        ]
        running: true
    }

    Connections {
        target: NiriService
        function onWindowsChanged() {
            // timerUntilPauseUnpause.running = true
            if (NiriService.windows[0]) {
                pause.running = true
            } else {
                resume.running = true
            }
        }
    }
    // Timer {
        // id: timerUntilPauseUnpause
        // interval: 1000;
        // onTriggered: {
        // }
    // }
    // Timer {
        // id: timerUntilPauseUnpause
        // interval: 100;
        // onTriggered: {
            // if (selectedWorkspaceHasWindows()) {
                // pause.running = true
            // } else {
                // resume.running = true
            // }
        // }
    // }
    // function selectedWorkspaceHasWindows() {
        // for (const window of NiriService.windows) {
            // if (window.workspace_id == NiriService.focusedWorkspaceId) {L
                // return true
            // }
        // }
        // return false
    // }
    // function selectedWorkspaceHasWindows() {
        // for (const currentOutputWorkspace of NiriService.currentOutputWorkspaces) {
            // for (const window of NiriService.windows) {
                // if (window.workspace_id == currentOutputWorkspace.id) {
                    // return true
                // }
            // }
        // }
        // return false
    // }

    Process {
        command: ["mpvpaper", "-o", "input-ipc-server=/tmp/mpv-socket no-audio loop panscan=1.0", "--mute=yes", "*", getRandomWallpaper()]
        running: true
    }

    property bool videoPaused: false

    Process {
        id: pause
        command: ["sh", "-c", "echo '{ \"command\": [\"set_property\", \"pause\", true] }' | socat - /tmp/mpv-socket"]
    }
    Process {
        id: resume
        command: ["sh", "-c", "echo '{ \"command\": [\"set_property\", \"pause\", false] }' | socat - /tmp/mpv-socket"]
    }

    Variants {
        model: Quickshell.screens;

        delegate: Component {
            PanelWindow {

                required property var modelData

                color: "transparent"

                screen: modelData

                WlrLayershell.layer: WlrLayer.Background
                WlrLayershell.exclusionMode: ExclusionMode.Ignore

                id: wallpaperWindow

                anchors {
                    top: true
                    bottom: true
                    left: true
                    right: true
                }

                // property real mouseX
                // property real mouseY

                // property real animMouseX
                // property real animMouseY

                // property bool followMouse: !NiriService.overviewOpen

                // property real scaled: followMouse ? 1.01 : 1

                // Behavior on scaled {
                    // NumberAnimation { duration: 400; easing.type: Easing.OutQuad; }
                // }

                // Timer {
                    // interval: 16
                    // running: wallpaperWindow.followMouse
                    // repeat: true
                    // onTriggered: {
                        // animMouseX += (mouseX - animMouseX)/24
                        // animMouseY += (mouseY - animMouseY)/24
                    // }
                // }
                // MouseArea {
                    // id: mainMouseArea
                    // hoverEnabled: true
                    // anchors.fill: parent

                    // Handler for when the mouse position changes while hovering (if hoverEnabled is true)
                    // onPositionChanged: {
                        // wallpaperWindow.mouseX = mouse.x
                        // wallpaperWindow.mouseY = mouse.y
                    // }
                    // onClicked: {
                        // console.log(JSON.stringify(NiriService.sortedWindows))
                        // console.log(modelData.name)
                    // }
                // }

                // Image {
                    // id: backgroundImage
                    // smooth: true
                    // mipmap: true
                    // cache: true
                    // visible: false
                    // anchors.fill: parent
                    // source: randomWallpaper
                    // fillMode: Image.PreserveAspectCrop
                    // horizontalAlignment: Image.AlignHCenter
                    // verticalAlignment: Image.AlignVCenter
                // }

                // Video {
                    // id: backgroundImage
                    // smooth: true
                    // mipmap: true
                    // cache: true
                    // visible: false
                    // anchors.fill: parent
                    // source: "rem-battle-ready-rezero-moewalls-com.mp4"
                    // fillMode: Video.PreserveAspectCrop
                    // horizontalAlignment: Video.AlignHCenter
                    // verticalAlignment: Video.AlignVCenter
                // }

                // Rectangle {
                    // id: shape
                    // radius: NiriService.overviewOpen ? 8 : 0
                    // visible: false
                    // layer.enabled: true
                    // layer.smooth: true
                    // anchors.fill: parent
                // }

                // MultiEffect {
                    // anchors.fill: parent
                    // source: backgroundImage
                    // maskEnabled: true
                    // maskSource: shape
                    // visible: true
                    // maskThresholdMin: 0.5
                    // maskSpreadAtMin: 1

                    // transform: Scale {
                        // origin.x: animMouseX
                        // origin.y: animMouseY
                        // xScale: wallpaperWindow.scaled
                        // yScale: wallpaperWindow.scaled
                    // }
                // }

                Rectangle {
                    id: border
                    visible: NiriService.overviewOpen
                    color: "transparent"
                    border {
                        width: 1
                        color: Qt.rgba(0.3,0.3,0.3,1)
                    }
                    radius: 8
                    anchors.fill: parent
                }

                PanelWindow {

                    screen: modelData

                    anchors {
                        top: true
                        bottom: true
                        left: true
                        right: true
                    }

                    WlrLayershell.layer: WlrLayer.Background
                    WlrLayershell.namespace: "dms:blurredWallpaper"
                    WlrLayershell.exclusionMode: ExclusionMode.Ignore

                    Image {
                        id: blurredImage
                        anchors.fill: parent
                        source: imageWallpaper
                        fillMode: Image.PreserveAspectCrop
                        horizontalAlignment: Image.AlignHCenter
                        verticalAlignment: Image.AlignVCenter
                    }

                    Rectangle {
                        color: "black"
                        opacity: 0.75
                        anchors.fill: parent
                        z: 1
                    }

                    MultiEffect {
                        source: blurredImage
                        anchors.fill: parent
                        blurEnabled: true
                        blur: 0.8
                        blurMax: 75
                        autoPaddingEnabled: false
                    }
                }
            }
        }
    }
}
