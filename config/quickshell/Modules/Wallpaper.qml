import QtQuick
import QtCore
import Quickshell
import Qt.labs.folderlistmodel
import Quickshell.Wayland
import QtQuick.Effects
import QtQuick.Shapes

import qs.Services

Item {
    readonly property string configDir: StandardPaths.writableLocation(
        StandardPaths.ConfigLocation
    )

    FolderListModel {
        id: imagesModel
        folder: configDir + "/wallpapers"
        nameFilters: ["*.png", "*.jpg", "*.jpeg"]
        showDirs: false
        showHidden: false
    }

    function getRandomWallpaper() {
        let index = Math.floor(Math.random() * imagesModel.count)
        return imagesModel.get(index, "fileUrl")
    }
    readonly property string randomWallpaper: getRandomWallpaper()
    
    Variants {
        model: Quickshell.screens;

        delegate: Component {
            PanelWindow {

                required property var modelData

                color: "transparent"

                screen: modelData

                aboveWindows: false
                exclusiveZone: 0
                
                id: wallpaperWindow
                
                anchors {
                    top: true
                    bottom: true
                    left: true
                    right: true
                }

                Image {
                    id: backgroundImage
                    smooth: true
                    mipmap: true
                    cache: true
                    visible: false
                    anchors.fill: parent
                    source: randomWallpaper
                    fillMode: Image.PreserveAspectCrop
                    horizontalAlignment: Image.AlignHCenter
                    verticalAlignment: Image.AlignVCenter
                }

                Rectangle {
                    id: shape
                    radius: NiriService.overviewOpen ? 8 : 0
                    visible: false
                    layer.enabled: true
                    layer.smooth: true
                    anchors.fill: parent
                }

                MultiEffect {
                    anchors.fill: parent
                    source: backgroundImage
                    maskEnabled: true
                    maskSource: shape
                    visible: true
                    maskThresholdMin: 0.5
                    maskSpreadAtMin: 1
                }

                // PanelWindow {
                    // screen: modelData

                    // anchors {
                        // bottom: true
                        // left: true
                        // right: true
                    // }
                    // implicitHeight: 20
                    // visible: NiriService.overviewOpen

                    // color: "transparent"
                // }

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
                        source: randomWallpaper
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
