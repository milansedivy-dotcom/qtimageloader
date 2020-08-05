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


    property url sourceFile;

    FileDialog {
        id: fileDialog

        title: "Please choose a file"
        folder: shortcuts.home
        selectMultiple: false
        onAccepted: {
           root.sourceFile = fileDialog.fileUrl;
           //Qt.quit()
           }
        onRejected: {
           Qt.quit()
           }
          //Component.onCompleted: visible = true
    }

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
            onClicked: fileDialog.open();
        }

        Button {
            id: folderButton
            text: qsTr("Select Folder")
        }

    }
}
