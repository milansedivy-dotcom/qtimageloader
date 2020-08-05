import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Dialogs 1.2
import QtQuick.Controls 1.4
import QtQuick.Layouts 1.12

Window {
    id: root
    visible: true
    width: 640
    height: 480
    title: qsTr("Hello World")

    RowLayout {

        id: menu
        spacing: 10

        anchors {
            top: parent.top
            left: parent.left
            leftMargin: 20
            topMargin: 15
        }

        Button {
            id: multipleFilesButton
            text: qsTr("Select File(s)")
        }

        Button {
            id: folderButton
            text: qsTr("Select Folder")
        }

    }
}
