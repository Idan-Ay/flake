import QtQuick
import Quickshell
import Quickshell.Services.Pipewire
import Quickshell.Bluetooth

import qs.Components

Row {
    PwObjectTracker {
        objects: [Pipewire.defaultAudioSink, Pipewire.defaultAudioSource]
    }

    property bool isMuted: Pipewire.defaultAudioSource.audio.muted
    property bool isNoSound: Pipewire.defaultAudioSink.audio.muted
    property real volume: Pipewire.defaultAudioSource.audio.volume
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
