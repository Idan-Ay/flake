import QtQuick
import Quickshell

import qs.Modules

ShellRoot {

    Loader {
        asynchronous: false
        sourceComponent: Bar{}
    }
}