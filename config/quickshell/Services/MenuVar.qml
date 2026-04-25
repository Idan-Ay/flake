import QtCore
import QtQuick
import Quickshell

pragma Singleton

pragma ComponentBehavior

Singleton {
    property bool open
    property string selection
    property int appSelection: 0
}
