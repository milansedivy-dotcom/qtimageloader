import QtQuick 2.0
import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.5
import QtQuick.Dialogs 1.2

Window {    

    signal currentAngleChanged(int direction)

    onCurrentAngleChanged: {
        if (direction > 0)
            image.currentAngle = (image.currentAngle + 90) % 360;
        else
            image.currentAngle = (image.currentAngle - 90) % 360;

        _imageResources.sourceFiles[_imageResources.currentIndex].currentRotation = image.currentAngle;
        console.log(image.currentAngle);
    }

    Connections{
        target: _imageResources
        onCurrentIndexChanged:{
            image.source = "image://myprovider/" + _imageResources.sourceFiles[index].imageSource;
        }
    }

    id: root
    width: 640
    height: 480
    title: if(root.visible){ qsTr("ImageViewer: ") + _imageResources.sourceFiles[_imageResources.currentIndex].imageId } else qsTr("")

        Image {
            property real scaleFactor: 1
            property int currentAngle: if(root.visible){_imageResources.sourceFiles[_imageResources.currentIndex].currentRotation} else 0
            property real positionX: 1
            property real positionY: 1

            source: if(root.visible){"image://myprovider/" + _imageResources.sourceFiles[_imageResources.currentIndex].imageSource;} else ""
            id: image

            transform: [
                Scale {
                yScale: image.scaleFactor;
                xScale: image.scaleFactor;
                },
                Translate {
                    id: translationProperties
                    x: (root.width - image.width*image.scaleFactor)/2;
                    y: (root.height - image.height*image.scaleFactor)/2;
                },
                Rotation {
                    id: rotationProperties
                    angle: image.currentAngle
                    origin.x: image.width/2+translationProperties.x // might not work with translation
                    origin.y: image.height/2+translationProperties.y // might not work with translation
                }

            ]
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
            if (index == 0) {
                timer.start();
            }
            else if (index == 1)
            {
                timer.stop();
            }
            else if (index == 2)
                root.currentAngleChanged(-1);
            else if (index == 3)
                root.currentAngleChanged(1);
        }
    }

    TextField {
        id: timerWrapper
        height: imageControls.height
        width: 50
        anchors {
            right: imageControls.left
            top: imageControls.top
            rightMargin: 20
        }
        text: qsTr(timer.time.toString())

        validator: IntValidator{bottom: 1; top: 99}

        onEditingFinished: {
            timer.time = timerWrapper.text;
            console.log(timer.time);
        }
        onAccepted: {
            timerWrapper.focus = false
        }


        Timer {
            property int time: 5
            id: timer
            interval: time*1000; running: false; repeat: true
                 onTriggered: {
                     _imageResources.setCurrentIndex(_imageResources.currentIndex+1);
                     image.currentAngle = _imageResources.sourceFiles[_imageResources.currentIndex].currentRotation;
                 }
        }
    }
}
