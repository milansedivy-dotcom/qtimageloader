import QtQuick 2.0
import QtQuick.Layouts 1.12
import QtQuick.Controls 2.12

RowLayout {
    signal keyPressed(int index)
    Repeater {
        id: repeater
        model: ["PLAY", "STOP", "ROTATE LEFT", "ROTATE RIGHT"]
        Button {
            text: modelData
            onClicked: {
                keyPressed(index);
                if (modelData == "PLAY") {
                    repeater.itemAt(0).highlighted = true;
                }
                if (modelData == "STOP") {
                    repeater.itemAt(0).highlighted = false;
                }
            }
        }
    }
}



