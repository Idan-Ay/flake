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

                Shape {
                    id: shape
                    visible: false
                    anchors.fill: parent

                    layer.enabled: true
                    layer.smooth: true

                    property int indent: NiriService.overviewOpen ? 16 : 0

                    ShapePath {
                        id: shapePath
                        startX: 0; startY: 0

                        strokeWidth: -1

                        PathLine { x: shape.width; y: 0}
                        PathLine { x: shape.width; y: shape.height - shape.indent }
                        PathLine { x: shape.width - shape.indent; y: shape.height}
                        PathLine { x: 0; y: shape.height }
                    }
                }


                Shape {
                    visible: NiriService.overviewOpen
                    anchors.fill: parent

                    z: 1

                    ShapePath {
                        startX: shape.width -2 ; startY: 0

                        strokeWidth: 4
                        strokeColor: "white"
                        fillColor: "transparent"

                        PathLine { x: shape.width -2 ; y: shape.height - shape.indent -2 }
                        PathLine { x: shape.width - shape.indent ; y: shape.height -2 }
                        PathLine { x: 0; y: shape.height -2 }
                    }
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
