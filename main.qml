import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Dialogs 1.2
import QtQuick.Controls 1.4
import QtQuick.Layouts 1.12
//import qt.noob.imageResources 1.0
import qt.noob.imageData 1.0

Window {
//    property url sourceFile;
//    property list<ImageData> sourceFiles;
//    property url sourceFolder;

    id: root
    visible: true
    width: 640
    height: 480
    minimumWidth: menu.width*1.8
    minimumHeight: 480
    title: qsTr("ImageViewer")

//    Component.onCompleted: {
//        root.sourceFiles = _imageResources.sourceFiles;
//        console.log(_imageResources.sourceFiles[0].imageId);
//        console.log(root.sourceFiles[0].imageSource);
//    }

//    ImageResources {
//        id: temporaryStuff
//        sourceFiles: [
//            ImageData {imageSource: "/home/vakokocurik/Downloads/Phalaenopsis_JPEG.jpg"}
//        ]
//        Component.onCompleted: {
//            console.log(temporaryStuff.sourceFiles)//.imageData(0).imageSource);
//        }
//    }

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
                //console.log(root.sourceFile);
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
            //needs to be done differently
            _imageResources.setCurrentIndex(row)
            var component = Qt.createComponent("presenter_window.qml")
            component.createObject(ApplicationWindow, {})
        }
    }

    Button {
        id: populate
        text: qsTr("Populate")
        anchors {
            right: tableView.right
            top: tableView.bottom
            topMargin: 20
        }
        onClicked: tableView.model = _imageResources.sourceFiles;
    }
}
