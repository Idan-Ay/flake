
import QtQuick
import QtQuick.Shapes

Shape {
    id: shape

    property bool bottomLeftSmoothing: false

    property color borderColor: "white"
    property int borderWidth: 1
    property int radius: 6

    layer.enabled: true
    layer.samples: 4

    ShapePath {
        fillColor: "transparent"
        strokeWidth: shape.borderWidth
        strokeColor: shape.borderColor
        joinStyle: ShapePath.RoundJoin
        capStyle: ShapePath.RoundCap

        startX: 0.5; startY: -0.5

        PathLine { x: 0.5; y: shape.height - shape.radius - 0.5 }

        PathQuad {
            x: shape.radius + 0.5
            y: shape.height - 0.5
            controlX: 0.5
            controlY: shape.height - 0.5
        }

        // PathLine { x: shape.radius + 0.5; y: shape.height - 0.5 }

        PathLine { x: shape.width - shape.radius - 0.5; y: shape.height - 0.5 }

        // Bottom-right corner
        PathQuad {
            x: shape.width - 0.5
            y: shape.height - shape.radius - 0.5
            controlX: shape.width - 0.5
            controlY: shape.height - 0.5
        }

        PathLine { x: shape.width - 0.5; y: 0.5 }

    }
}
