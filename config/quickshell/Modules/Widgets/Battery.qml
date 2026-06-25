import QtQuick
import Quickshell
import Quickshell.Services.UPower

import qs.Components

Underline {
    visible: UPower.displayDevice.isLaptopBattery
    width: 170
    
    function getTimeFromSec(sec) {
        var sec_num = parseInt(sec, 10);
        var hours   = Math.floor(sec_num / 3600);
        var minutes = Math.floor((sec_num - (hours * 3600)) / 60);
        var seconds = sec_num - (hours * 3600) - (minutes * 60);

        if (hours   < 10) {hours   = "0"+hours;}
        if (minutes < 10) {minutes = "0"+minutes;}
        if (seconds < 10) {seconds = "0"+seconds;}
        return hours+':'+minutes+':'+seconds;
    }

    property var batteryIcons: ["󱊡 ", "󱊢 ", "󱊣 "]
    property var batteryChargingIcons: ["󱊤 ", "󱊥 ", "󱊦 "]

    function getBatteryIcon() {
        const iconIndex = Math.round(UPower.displayDevice.percentage * 2)
        return UPower.displayDevice.state === UPowerDeviceState.Charging
            ? batteryChargingIcons[iconIndex]
            : batteryIcons[iconIndex]
    }

    function timeToFullOrEmpty() {
        return UPower.displayDevice.state === UPowerDeviceState.Charging
            ? UPower.displayDevice.timeToFull
            : UPower.displayDevice.timeToEmpty
    }

    function isBatterLowAndNotCharging() {
        return UPower.displayDevice.state !== UPowerDeviceState.Charging
            && UPower.displayDevice.percentage <= 0.2
    }

    Row {
        anchors.verticalCenter: parent.verticalCenter
        SText {
            text: getBatteryIcon() + Math.round(UPower.displayDevice.percentage * 100) + "%"
            color: isBatterLowAndNotCharging() ? "#F62B5A" : "white"
            elide: Text.ElideRight
            width: 60
        }
        SText {
            text: getTimeFromSec(timeToFullOrEmpty())
            color: isBatterLowAndNotCharging() ? "#F62B5A" : "white"
            elide: Text.ElideRight
            width: 80
        }
    }
}
