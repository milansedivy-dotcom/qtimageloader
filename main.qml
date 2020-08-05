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
    property var sourceFiles;
    property url sourceFolder;

    FileDialog {
        id: multipleFilesDialog

        title: "Please choose a file"
        folder: shortcuts.home
        selectMultiple: true
        onAccepted: {
            if (multipleFilesDialog.fileUrls.length > 1) {
                root.sourceFiles = multipleFilesDialog.fileUrls;
                console.log(root.sourceFiles);
            }
            else {
                root.sourceFile = multipleFilesDialog.fileUrl;
                var component = Qt.createComponent("presenter_window.qml")
                component.createObject(ApplicationWindow, {sourceFile = root.sourceFile})
                console.log(root.sourceFile);
            }
           }
        onRejected: {
           Qt.quit()
           }
          //Component.onCompleted: visible = true
    }

    FileDialog {
        id: selectFolderDialog

        title: "Please choose a folder"
        folder: shortcuts.home
        selectFolder: true
        onAccepted: {
           root.sourceFolder = selectFolderDialog.folder;
            console.log(root.sourceFolder);
           //Qt.quit()
        }
        onRejected: {
           //Qt.quit()
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
            onClicked: multipleFilesDialog.open();
        }

        Button {
            id: folderButton
            text: qsTr("Select Folder")
            onClicked: selectFolderDialog.open();
        }

    }
}
