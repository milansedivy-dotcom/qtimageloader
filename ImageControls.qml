import QtQuick 2.0
import QtQuick.Layouts 1.12
import QtQuick.Controls 2.12

RowLayout {
    signal keyPressed(int index)
    Repeater {
        model: ["PLAY", "STOP", "ROTATE LEFT", "ROTATE RIGHT"]
        Button {
            text: modelData
            onClicked: keyPressed(index);
        }
    }
}



