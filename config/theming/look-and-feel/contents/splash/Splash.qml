/*
 *   Copyright 2014 Marco Martin <mart@kde.org>
 *
 *   This program is free software; you can redistribute it and/or modify
 *   it under the terms of the GNU General Public License version 2,
 *   or (at your option) any later version, as published by the Free
 *   Software Foundation
 *
 *   This program is distributed in the hope that it will be useful,
 *   but WITHOUT ANY WARRANTY; without even the implied warranty of
 *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *   GNU General Public License for more details
 *
 *   You should have received a copy of the GNU General Public
 *   License along with this program; if not, write to the
 *   Free Software Foundation, Inc.,
 *   51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
 */

import QtQuick 2.5
import QtQuick.Window 2.2
import org.kde.plasma.core 2.0 as PlasmaCore
import QtGraphicalEffects 1.0

Rectangle {
    id: root
    color: "#1f1f1f"
    anchors.fill: parent
    property int stage

    // onStageChanged: {
    //     if (stage == 2) {
    //         introAnimation.running = true;
    //     } else if (stage == 5) {
    //         introAnimation.target = busyIndicator;
    //         introAnimation.from = 1;
    //         introAnimation.to = 0;
    //         introAnimation.running = true;
    //     }
    // }


    // Image {
    //     id: busyIndicator
    //     anchors.horizontalCenter: parent.horizontalCenter
    //     anchors.verticalCenter: parent.verticalCenter
    //     width: 96
    //     height: 96
    //     source: "images/logo.png"
    //     RotationAnimator on rotation {
    //         id: rotationAnimator
    //         from: 0
    //         to: 360
    //         duration: 3900
    //         loops: Animation.Infinite
    //     }
    // }

    // OpacityAnimator {
    //     id: introAnimation
    //     running: false
    //     target: busyIndicator
    //     from: 0
    //     to: 1
    //     duration: 1000
    //     easing.type: Easing.InOutQuad
    // }




    property variant images : [
        "images/spinner1.png",
        "images/spinner2.png",
        "images/spinner3.png",
        "images/spinner4.png",
        "images/spinner5.png",
        "images/spinner6.png",
        "images/spinner7.png",
        "images/spinner8.png",
    ];
    property int currentImage : 0;

    Repeater {
        id: repeaterImg;
        model: images;
        delegate: Image {
            id: spinner
            source: modelData;
            asynchronous: true;
            height: 60;
            width: 60;
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            visible: (model.index === currentImage);

            OpacityAnimator {
                target: spinner;
                from: 0;
                to: 1;
                duration: 100;
                running: true
            }
        }
    }

    Timer {
        id: timerAnimImg;
        interval: 125; // here is the delay between 2 images in msecs
        running: true; // stopped by default, use start() or running=true to launch
        repeat: true;
        onTriggered: {
            if (currentImage < images.length -1) {
                currentImage++; // show next image
            }
            else {
                currentImage = 0; // go back to the first image at the end
            }
        }
    }
}
