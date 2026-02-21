import QtQuick
import Quickshell
import Quickshell.Io

import qs.Components

Underline {
    Row {
        id: root

        spacing: 24

        property int cpuUsage: 0
        property int lastCpuTotal: 0
        property int lastCpuIdle: 0

        property int memActive: 0
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
            id: activeMemProc
            command: ["sh", "-c", "grep '^Active:' /proc/meminfo | awk '{print $2}'"]
            stdout: SplitParser {
                onRead: data => {
                    memActive = parseInt(data)
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
                activeMemProc.running = true
            }
        }

        SText {
            text: " " + root.cpuUsage + "%"
            font.pixelSize: 15
        }

        SText {
            text: " " + Math.round(100 * root.memActive / root.memTotal) + "% " + (root.memActive / 1000000).toFixed(2) + "GiB"
            font.pixelSize: 15
        }
    }
}
