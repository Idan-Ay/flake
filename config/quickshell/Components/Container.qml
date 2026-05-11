import QtQuick
import Quickshell

Rectangle {
    id: shape
    property bool bottomLeftSmoothing: false

    bottomRightRadius: 8
    color: Qt.rgba(0.0039215686, 0.0039215686, 0.0039215686, 0.8)
    property color borderColor: Qt.rgba(0.3,0.3,0.3,1)

    Element {
        anchors.fill: parent
        borderColor: shape.borderColor
    }
}
