import QtQuick
import Quickshell
import QtQuick.Controls

import qs.Components
import qs.Services

PanelWindow {
  screen: Screens.mainScreen
  id: launcherRoot

  property bool launcherActive: true;

  visible: launcherRoot.launcherActive

  anchors {
    top: true
    left: true
    right: true
    bottom: true
  }

  MouseArea {
    anchors.fill: parent
    onClicked: launcherRoot.launcherActive = false
  }

  color: "transparent"
  
  Container {
    width: 560
    height: 60
    anchors.centerIn: parent
    borderColor: "white"
    TextField {
      focus: launcherRoot.launcherActive
      selectByMouse: true
      anchors {
        left: parent.left
        leftMargin: 12
        right: parent.right
        rightMargin: 12
      }
      height: 60
      placeholderText: qsTr("Launcher")
      font {
        family: "serif"
        pointSize: 12
      }
      placeholderTextColor: "grey"
      background: null
    }
  }
}

