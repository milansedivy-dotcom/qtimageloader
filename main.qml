import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Dialogs 1.2
import QtQuick.Controls 1.4
import QtQuick.Layouts 1.12

Window {
    property url sourceFile;
    property var sourceFiles;
    property url sourceFolder;

    id: root
    visible: true
    width: 640
    height: 480
    minimumWidth: menu.width*1.8
    minimumHeight: 480
    title: qsTr("ImageViewer")


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
                component.createObject(ApplicationWindow, {sourceFile = root.sourceFile.toString().replace(/^(file:\/{2})/,"")})
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

    TableView {
        id: tableView
        height: root.height/2
        width: root.width/1.3

        anchors {
            top: menu.bottom
            topMargin: 10
            left: parent.left
            leftMargin: 20
        }

        TableViewColumn {
            title: "Files"
            width: tableView.width*(2/3)
            resizable: false
        }
        TableViewColumn {
            title: "Options"
            width: tableView.width*(1/3)-2
            resizable: false
        }
    }
}
