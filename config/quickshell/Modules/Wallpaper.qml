import QtQuick
import QtCore
import Quickshell
import Qt.labs.folderlistmodel
import Quickshell.Wayland
import QtQuick.Effects

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
                    anchors.fill: parent
                    source: randomWallpaper
                    fillMode: Image.PreserveAspectCrop
                    horizontalAlignment: Image.AlignHCenter
                    verticalAlignment: Image.AlignVCenter
                }

                PanelWindow {

                    screen: modelData
                    
                    anchors.top: true
                    anchors.bottom: true
                    anchors.left: true
                    anchors.right: true
                
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