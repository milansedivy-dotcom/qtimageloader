import QtQuick 2.0
import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.5
import QtQuick.Dialogs 1.2

Window {    

    signal currentAngleChanged(int direction)

    onCurrentAngleChanged: {
        //calling currentAngleChanged(0) will only update actualX and actualY properties of translationProperties
        if (direction > 0) {
            image.currentAngle = (image.currentAngle + 90) % 360;
            _imageResources.sourceFiles[_imageResources.currentIndex].currentRotation = image.currentAngle;
        }
        else if (direction < 0) {
            image.currentAngle = (image.currentAngle - 90) % 360;
            _imageResources.sourceFiles[_imageResources.currentIndex].currentRotation = image.currentAngle;
        }

        if (image.currentAngle % 180 > 0) {
            translationProperties.actualX = translationProperties.y;
            translationProperties.actualY = translationProperties.x;
        } else {
            translationProperties.actualX = translationProperties.x;
            translationProperties.actualY = translationProperties.y;
        }

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
    minimumHeight: 480
    minimumWidth: 640
    title: if(root.visible){ qsTr("ImageViewer: ") + _imageResources.sourceFiles[_imageResources.currentIndex].imageId } else qsTr("")

        Image {
            property real scaleFactor: 1
            property int currentAngle: if(root.visible){_imageResources.sourceFiles[_imageResources.currentIndex].currentRotation} else 0

            source: if(root.visible){"image://myprovider/" + _imageResources.sourceFiles[_imageResources.currentIndex].imageSource;} else ""
            id: image
            transform: [
                Scale {
                id: scaleProperties
                yScale: image.scaleFactor;
                xScale: image.scaleFactor;
                },
                Translate {
                    property int actualX: x
                    property int actualY: y
                    id: translationProperties
                    x: (root.width - image.width*image.scaleFactor)/2;
                    y: (root.height - image.height*image.scaleFactor)/2;
                },
                Rotation {
                    id: rotationProperties
                    angle: image.currentAngle
                    origin.x: image.width/2*image.scaleFactor+translationProperties.x
                    origin.y: image.height/2*image.scaleFactor+translationProperties.y
                }


            ]

            function centerImage() {
                console.log(translationProperties.x);
                image.x = 0;
                image.y = 0;

            }


            function updateTranslation() {
                translationProperties.x = (root.width - image.width*image.scaleFactor)/2;
                translationProperties.y = (root.height - image.height*image.scaleFactor)/2;
            }

            function updateUI() {
                image.currentAngle = _imageResources.sourceFiles[_imageResources.currentIndex].currentRotation;
                updateTranslation();
                console.log("X: " + translationProperties.x);
                console.log("Y: " + translationProperties.y);
                root.currentAngleChanged(0); // updates actualX and actualY properties of translationProperties.
                console.log("ActualX: " + translationProperties.actualX);
                console.log("ActualY: " + translationProperties.actualY);
                console.log("scaleFactor: " + image.scaleFactor);
                mouseArea.drag.minimumX = -image.width/2*image.scaleFactor - translationProperties.actualX;
                mouseArea.drag.minimumY = -image.height/2*image.scaleFactor - translationProperties.actualY;
                mouseArea.drag.maximumX = root.width - image.width/2 *image.scaleFactor - translationProperties.actualX;
                mouseArea.drag.maximumY = root.height - image.height/2 *image.scaleFactor - translationProperties.actualY - imageControls.height*2;
            }

            onStatusChanged: if (image.status == Image.Ready) {
                                 updateUI();
                             }

            MouseArea {
                id: mouseArea
                drag.target: image
                drag.axis: Drag.XAndYAxis
                drag.minimumX: -image.width/2*image.scaleFactor - translationProperties.actualX
                drag.minimumY: -image.height/2*image.scaleFactor - translationProperties.actualY
                drag.maximumX: root.width - image.width/2 *image.scaleFactor - translationProperties.actualX
                drag.maximumY: root.height - image.height/2 *image.scaleFactor - translationProperties.actualY - imageControls.height*2

                anchors {
                    fill: parent
                    top: parent.top
                    left: parent.left
                }

                onWheel: {
                    if (wheel.modifiers & Qt.ControlModifier) {
                        if (wheel.angleDelta.y > 0)
                            parent.scaleFactor += 0.2;
                        else if (parent.scaleFactor - 0.2 >= 0.2)
                            parent.scaleFactor -= 0.2;

                    }
                    image.updateTranslation();
                    console.log(translationProperties.x);
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
            else if (index == 4) {
                image.centerImage();
                root.currentAngleChanged(0);
            }
        }
    }

    TextField {
        id: timerWrapper
        height: imageControls.height
        width: 45
        anchors {
            right: imageControls.left
            top: imageControls.top
            rightMargin: 5
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
