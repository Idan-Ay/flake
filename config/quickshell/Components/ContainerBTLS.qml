import QtQuick
import Quickshell

Rectangle {
    id: shape

		bottomLeftRadius: 8
    bottomRightRadius: 8
    color: Qt.rgba(0,0,0,0.75)
    property color borderColor: Qt.rgba(0.3,0.3,0.3,1)

    ElementBTLS {
        anchors.fill: parent
        borderColor: shape.borderColor
    }
}
