import QtQuick
import QtQuick.Shapes
import Quickshell

Shape {
    id: shape

    property color borderColor: "white"
    property int borderWidth: 2

    property int indent: 8

    ShapePath {
        startX: shape.width; startY: 0

        fillColor: "transparent"
        strokeWidth: shape.borderWidth
        strokeColor: shape.borderColor


        PathLine { x: shape.width; y: shape.height - shape.indent }
        PathLine { x: shape.width - shape.indent; y: shape.height}
        PathLine { x: 0; y: shape.height }
    }
}