import QtQuick
import Quickshell
import Quickshell.Services.Pipewire
import Quickshell.Bluetooth

import qs.Components
import qs.Services

Row {
    property bool isMuted: DeviceService.defaultAudioSource.audio.muted
    property bool isNoSound: DeviceService.defaultAudioSink.audio.muted
    property real volume: DeviceService.defaultAudioSource.audio.volume
    property bool bluetoothOn: Bluetooth.defaultAdapter.enabled

		BarIcon {
				text: isNoSound ? "  " : "  "
				active: !isNoSound
		}
		BarIcon {
				text: isMuted ? " " : ""
				active: !isMuted
		}
		BarIcon {
				text: bluetoothOn ? "󰂯" : "󰂲"
				active: bluetoothOn
		}
}
