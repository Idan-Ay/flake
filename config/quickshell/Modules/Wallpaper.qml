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
    function getFileNameWithoutExtension(fileUrl) {
        let parts = fileUrl.split("/")
        let fileName = parts[parts.length - 1]

        // Find the last dot in the filename
        let lastDotIndex = fileName.lastIndexOf(".")
        return fileName.substring(0, lastDotIndex)
    }
    property string imageWallpaperPath: "/tmp/image-wallpapers/"
    Connections {
        target: NiriService
        function onWindowsChanged() {
            if (NiriService.windows[0]) {
                pause.running = true
            } else {
                resume.running = true
            }
        }
    }

    Process {
        command: ["mpvpaper", "-o", "input-ipc-server=/tmp/mpv-socket no-audio loop panscan=1.0", "--mute=yes", "*", getRandomWallpaper()]
        running: true
    }

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

                Process {
                    id: createTmpPath
                    command: [
                        "mkdir", "-p", imageWallpaperPath
                    ]
                }

                Process {
                    id: ffmpegProcess
                    command: [
                        "ffmpeg",
                        "-i", getRandomWallpaper(),
                        "-vf", "select=eq(n\\,0)",
                        "-vframes", "1",
                        imageWallpaperPath + getFileNameWithoutExtension(getRandomWallpaper()) + ".png"
                    ]
                }

                Image {
                    id: blurredImage
                    anchors.fill: parent
                    fillMode: Image.PreserveAspectCrop
                    horizontalAlignment: Image.AlignHCenter
                    verticalAlignment: Image.AlignVCenter
                }

                Timer {
                    id: applyBlurredImage
                    interval: 100
                    onTriggered: blurredImage.source = imageWallpaperPath + getFileNameWithoutExtension(getRandomWallpaper()) + ".png"
                }

                Component.onCompleted: {
                    createTmpPath.running = true
                    ffmpegProcess.running = true
                    applyBlurredImage.running = true
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
