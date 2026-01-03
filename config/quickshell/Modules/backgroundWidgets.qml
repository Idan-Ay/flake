import QtQuick
import QtCore
import Quickshell

import qs.Components

PanelWindow {
				anchors {
								right: 120
								top: 120
				}
				implicitHeight: 320
				implicitWidth: 620


				WlrLayershell.layer: WlrLayer.Background
				WlrLayershell.exclusionMode: ExclusionMode.Ignore

				SText {
								text: "12:20"
								fontSize: 52
				}
}
