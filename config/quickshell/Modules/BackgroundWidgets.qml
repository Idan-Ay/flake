import QtQuick
import Quickshell
import Quickshell.Wayland

import qs.Components

PanelWindow {
				anchors {
								right: true
								top: true
				}
				implicitHeight: 320
				implicitWidth: 620

				WlrLayershell.layer: WlrLayer.Background
				WlrLayershell.exclusionMode: ExclusionMode.Ignore

				color: "transparent"

				SText {
								text: "12:20"
								font.pixelSize: 52
								anchors.bottom: parent.bottom
				}
}
