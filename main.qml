import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Dialogs 1.2
import QtQuick.Controls 2.5
import QtQuick.Controls 1.4
import QtQuick.Layouts 1.12
import qt.noob.imageData 1.0

Window {

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
        nameFilters: ["*.jpg", "*.jpeg"]
        onAccepted: {
            if (multipleFilesDialog.fileUrls.length > 1) {
                _imageResources.appendMultipleImages(multipleFilesDialog.fileUrls);
            }
            else {
                _imageResources.appendImage(multipleFilesDialog.fileUrl);
            }
           }
        onRejected: {
           Qt.quit()
           }
    }

    FileDialog {
        id: selectFolderDialog

        title: "Please choose a folder"
        folder: shortcuts.home
        selectFolder: true
        onAccepted: {
           _imageResources.appendDirectory(selectFolderDialog.folder);
        }
        onRejected: {
           Qt.quit()
           }

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
        model: _imageResources.sourceFiles

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
            role: "imageId"
        }


        TableViewColumn {
            id: options
            title: "Options"
            width: tableView.width*(1/3)-2
            resizable: false
            delegate: ToolButton {
                   id: deleteRow
                   text: "Delete"
                   onClicked: _imageResources.deleteImage(styleData.row);
            }
        }
        Connections{
            target: _imageResources
            onListChanged:{
                tableView.model = _imageResources.sourceFiles
            }
        }

        onDoubleClicked: {
            _imageResources.setCurrentIndex(row)
            var component = Qt.createComponent("presenter_window.qml")
            component.createObject(ApplicationWindow, {})
        }
        MouseArea {
            anchors.fill: parent
            acceptedButtons: Qt.RightButton
            onClicked: {
                if (mouse.button == Qt.RightButton)
                {
                    contextMenu.popup();
                }
            }
        }
        Menu {
            id: contextMenu
            MenuItem {
                text: "Delete ALL"
                onTriggered: _imageResources.deleteAll();
            }

        }
    }
}
