import QtQuick
import Quickshell

Rectangle {
    id: shape
    property bool bottomLeftSmoothing: false

    bottomLeftRadius: bottomLeftSmoothing ? 8 : 0
    bottomRightRadius: 8
    color: Qt.rgba(0,0,0,0.75)
    property color borderColor: Qt.rgba(0.3,0.3,0.3,1)

    Loader {
        asynchronous: false
        sourceComponent: shape.bottomLeftSmoothing ? ElementBTMS{} : Element{}
    }
    // Element {
        // anchors.fill: parent
        // borderColor: shape.borderColor
    // }
}
