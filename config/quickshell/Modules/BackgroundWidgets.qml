import QtQuick
import Quickshell
import Quickshell.Wayland

import qs.Components

PanelWindow {
				anchors {
								right: true
								top: true
								bottom: true
				}
				implicitWidth: 1260

				WlrLayershell.layer: WlrLayer.Background
				WlrLayershell.exclusionMode: ExclusionMode.Ignore

				color: "transparent"


				SystemClock {
								id: clock
								precision: SystemClock.Seconds
				}
				Column {
								spacing: 200
								width: 600
								anchors.centerIn: parent
				
								Column {
												spacing: 20
												width: 600
												SText {
																text: Qt.formatDateTime(clock.date, "dddd").toUpperCase()
																font.pixelSize: 92
																font.family: "Anurati"
																horizontalAlignment: Text.AlignHCenter
																width: 600
												}
												SText {
																text: Qt.formatDateTime(clock.date, "dd MMMM yyyy")
																font.pixelSize: 42
																font.letterSpacing: 20
																horizontalAlignment: Text.AlignHCenter
																width: 600
												}
								}
								SText {
												text: Qt.formatDateTime(clock.date, "hh:mm")
												font.pixelSize: 72
												font.letterSpacing: 20
												horizontalAlignment: Text.AlignHCenter
												width: 600
								}
				}
}
