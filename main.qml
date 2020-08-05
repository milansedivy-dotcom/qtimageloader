import QtQuick 2.12
import QtQuick.Window 2.12

Window {
    visible: true
    width: 640
    height: 480
    title: qsTr("Hello World")

        Image {
            source: "file:/home/vakokocurik/QTstarterProjects/QtImageLoader/Phalaenopsis_JPEG.jpg"
            id: image

            property real scaleFactor: 1
            property int positionX: 0
            property int positionY: 0

            transform: Scale {
                yScale: image.scaleFactor;
                xScale: image.scaleFactor;
                origin.x: positionX;
                origin.y: positionY;
            }

            anchors {

            }

            MouseArea {
                id: mouseArea
                anchors {
                    fill: parent

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
