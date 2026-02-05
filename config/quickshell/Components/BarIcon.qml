import QtQuick
import Quickshell

Rectangle {
				property string text
				property bool active
				width: 36
				height: 27
				color: "transparent"
				SText {
						anchors.centerIn: parent
						text: parent.text
						color: parent.active ? "white" : Qt.rgba(0.5,0.5,0.5,1)
						font.pixelSize: 15
				}
}
