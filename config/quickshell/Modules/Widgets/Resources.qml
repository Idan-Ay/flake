import QtQuick
import Quickshell
import Quickshell.Io

import qs.Components

Row {
    property int cpuUsage: 0
    property int lastCpuTotal: 0
    property int lastCpuIdle: 0

    property int memAvailable: 0
    property int memTotal: 0

    Process {
        id: cpuProc
        command: ["sh", "-c", "head -1 /proc/stat"]
        stdout: SplitParser {
            onRead: data => {
                if (!data) return
                var p = data.trim().split(/\s+/)
                var idle = parseInt(p[4]) + parseInt(p[5])
                var total = p.slice(1, 8).reduce((a, b) => a + parseInt(b), 0)
                if (lastCpuTotal > 0) {
                    cpuUsage = Math.round(100 * (1 - (idle - lastCpuIdle) / (total - lastCpuTotal)))
                }
                lastCpuTotal = total
                lastCpuIdle = idle
            }
        }
        Component.onCompleted: running = true
    }
    Process {
        id: availableMemProc
        command: ["sh", "-c", "grep '^MemAvailable:' /proc/meminfo | awk '{print $2}'"]
        stdout: SplitParser {
            onRead: data => {
                memAvailable = parseInt(data)
            }
        }
        Component.onCompleted: running = true
    }
    Process {
        id: totalMemProc
        command: ["sh", "-c", "grep '^MemTotal:' /proc/meminfo | awk '{print $2}'"]
        stdout: SplitParser {
            onRead: data => {
                memTotal = parseInt(data)
            }
        }
        Component.onCompleted: running = true
    }

    Timer {
        interval: 2000
        running: true
        repeat: true
        onTriggered: {
            cpuProc.running = true
            availableMemProc.running = true
        }
    }

    spacing: 6


    Underline {
        width: 80
        SText {
            text: " " + cpuUsage + "%"
            font.pixelSize: 15
            anchors.verticalCenter: parent.verticalCenter
        }
    }
    Underline {
        width: 160
        SText {
            text: " " + Math.round(100 * (memTotal - memAvailable) / memTotal) + "% " + ((memTotal - memAvailable) / 1000000).toFixed(1) + "GiB"
            font.pixelSize: 15
            anchors.verticalCenter: parent.verticalCenter
        }
    }
}
