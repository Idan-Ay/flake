import QtQuick
import Quickshell

Rectangle {
    id: shape
    property bool bottomLeftSmoothing: false

    bottomLeftRadius: bottomLeftSmoothing ? 8 : 0
    bottomRightRadius: 8
    color: Qt.rgba(0.0039215686, 0.0039215686, 0.0039215686, 0.75)
    property color borderColor: Qt.rgba(0.3,0.3,0.3,1)

    Element {
        anchors.fill: parent
        borderColor: shape.borderColor
    }
}
