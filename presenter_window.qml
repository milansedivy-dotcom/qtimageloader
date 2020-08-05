import QtQuick 2.0

import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Dialogs 1.2

Window {
    id: root
    visible: true
    width: 640
    height: 480
    title: qsTr("Hello World")

    property url sourceFile;

        Image {
            source: root.sourceFile //"file:/home/vakokocurik/QTstarterProjects/QtImageLoader/Phalaenopsis_JPEG.jpg"
            id: image

            property real scaleFactor: 1
            property real positionX: 1
            property real positionY: 1

            transform: [
                Scale {
                yScale: image.scaleFactor;
                xScale: image.scaleFactor;
                },
                Translate {
                    id: translationProperties
                    x: (root.width - image.width*image.scaleFactor)/2;
                    y: (root.height - image.height*image.scaleFactor)/2;
                }
            ]
//probably a better way to do this, but my brain froze
            MouseArea {
                id: mouseArea
                drag.target: image
                drag.axis: Drag.XAndYAxis
                drag.minimumX: -image.width/2*image.scaleFactor - translationProperties.x
                drag.minimumY: -image.height/2*image.scaleFactor - translationProperties.y
                drag.maximumX: root.width - image.width/2 *image.scaleFactor - translationProperties.x
                drag.maximumY: root.height - image.height/2 *image.scaleFactor - translationProperties.y

                anchors {
                    fill: parent
                    top: parent.top
                    left: parent.left
                }

                onPositionChanged: {
                    parent.positionX = mouseX;
                    parent.positionY = mouseY;
                }

                onWheel: {
                    if (wheel.modifiers & Qt.ControlModifier) {
                        if (wheel.angleDelta.y > 0)
                            parent.scaleFactor += 0.2;
                        else if (parent.scaleFactor - 0.2 >= 0.2)
                            parent.scaleFactor -= 0.2;

                    }
                }
        }

    }
}
