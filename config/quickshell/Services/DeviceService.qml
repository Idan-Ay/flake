import QtCore
import QtQuick
import Quickshell
import Quickshell.Services.Pipewire

pragma Singleton

pragma ComponentBehavior

Singleton {

    property PwNode defaultAudioSink: Pipewire.defaultAudioSink
    property PwNode defaultAudioSource: Pipewire.defaultAudioSource

    PwNodeLinkTracker {
        id: defaultAudioSink
        node: Pipewire.defaultAudioSink
    }

    PwObjectTracker {
        objects: [Pipewire.defaultAudioSink, Pipewire.defaultAudioSource]
    }

    PwObjectTracker {
        objects: getSinkLinkSource()
    }

    function getSourceNodes() {
        let sourceNodes = []
        for (const node of Pipewire.nodes.values) {
            if (!node.isSink && !node.isStream && node.audio) {
                sourceNodes.push(node)
            }
        }
        return sourceNodes
    }
    function getSinkNodes() {
        let sinkNodes = []
        for (const node of Pipewire.nodes.values) {
            if (node.isSink && !node.isStream) {
                sinkNodes.push(node)
            }
        }
        return sinkNodes
    }

    function getSinkLinkSource() {
        let groups = []
        for (const linkGroup of defaultAudioSink.linkGroups) {
            groups.push(linkGroup.source)
        }
        return groups
    }
}
