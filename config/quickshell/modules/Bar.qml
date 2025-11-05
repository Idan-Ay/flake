import QtQuick
import QtQuick.Shapes

PanelWindow {

    id: bar

    anchors {
        top: true
        left: true
        right: true
    }

    implicitHeight: 30

    Shape {
        anchors.fill: parent

        ShapePath {
            startX: 0; startY: 0

            PathLine { x: bar.width; y: 0 }
            PathLine { x: bar.width; y: bar.height }
            PathLine { x: 0; y: bar.height }
            PathLine { x: 0; y: 0 }
        }
    }

}