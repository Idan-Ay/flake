import QtQuick
import Quickshell
import QtQuick.Effects

Variants {
  model: Quickshell.screens;

	delegate: Component {
		PanelWindow {
      required property var modelData
      screen: modelData
      anchors {
				top: true
				bottom: true
				right: true
				left: true
			}
			color: "transparent"
			mask: Region {}

			Rectangle {
				id: border
				// color: "black"
				anchors.centerIn: parent
				width: parent.width + 40
				height: parent.height + 40
				radius: 28
				border.width: 20
				border.color: "black"
				color: "transparent"
      }
		}
	}
}
