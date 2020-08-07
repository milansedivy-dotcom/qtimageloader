import QtQuick 2.0
import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Dialogs 1.2

Window {    
    //property string sourceFile;

    signal currentAngleChanged(int direction)

    onCurrentAngleChanged: {
        if (direction > 0)
            image.currentAngle = (image.currentAngle + 90) % 360;
        else
            image.currentAngle = (image.currentAngle - 90) % 360;
            console.log(image.currentAngle);
    }


    id: root
    visible: true
    width: 640
    height: 480
    title: qsTr("ImageViewer: ") + _imageResources.sourceFiles[_imageResources.currentIndex].imageId

        Image {
            property real scaleFactor: 1
            property int currentAngle: 0
            property real positionX: 1
            property real positionY: 1


            source: "image://myprovider/" + _imageResources.sourceFiles[_imageResources.currentIndex].imageSource; //imageWindow.sourceFile //"file:/home/vakokocurik/QTstarterProjects/QtImageLoader/Phalaenopsis_JPEG.jpg"
            id: image

            transform: [
                Scale {
                yScale: image.scaleFactor;
                xScale: image.scaleFactor;
                },
                Translate {
                    id: translationProperties
                    x: (root.width - image.width*image.scaleFactor)/2 + (image.height - image.width)/2;
                    y: (root.height - image.height*image.scaleFactor)/2 + (image.height - image.width)/2;
                },
                Rotation {
                    id: rotationProperties
                    angle: image.currentAngle
                    origin.x: image.width/2+translationProperties.x // might not work with translation
                    origin.y: image.height/2+translationProperties.y // might not work with translation
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
                drag.maximumY: root.height - image.height/2 *image.scaleFactor - translationProperties.y - imageControls.height*2

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

    ImageControls {
        id: imageControls
        anchors {
            bottom: parent.bottom
            horizontalCenter: parent.horizontalCenter
        }

        onKeyPressed: {
            console.log(index);
            if (index == 2)
                root.currentAngleChanged(-1);
            else if (index == 3)
                root.currentAngleChanged(1);
        }
    }

    Rectangle {
        id: timerWrapper
        height: imageControls.height
        width: 50
        anchors {
            right: imageControls.left
            top: imageControls.top
        }

        Timer {
            id: timer
        }
    }
}
