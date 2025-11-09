import QtQuick
import QtQuick.Shapes
import Quickshell

Shape {
    id: shape

    property color bg: Qt.rgba(0,0,0,0.75)

    property int indent: 8

    ShapePath {
        startX: 0; startY: 0

        strokeWidth: 0

        fillColor: shape.bg

        PathLine { x: shape.width; y: 0 }
        PathLine { x: shape.width; y: shape.height - shape.indent }
        PathLine { x: shape.width - shape.indent; y: shape.height}
        PathLine { x: 0; y: shape.height }
        PathLine { x: 0; y: 0 }
    }
}