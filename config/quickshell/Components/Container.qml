import QtQuick
import Quickshell

Rectangle {
    id: shape
    bottomRightRadius: 8
    color: Qt.rgba(0,0,0,0.75)
    property color borderColor: Qt.rgba(0.3,0.3,0.3,1)

    Element {
        anchors.fill: parent
        borderColor: shape.borderColor
    }
}
