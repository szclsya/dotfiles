import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import Quickshell
import Quickshell.Widgets
import Quickshell.Wayland
import Quickshell.Services.Notifications
import qs.Services

PanelWindow {
  id: layer
  required property var modelData
  screen: modelData
  // 22em
  readonly property int width: 16 * 22
  readonly property int height: width * 0.4

  WlrLayershell.namespace: "qs-notifications-" + (screen?.name || "unknown")
  visible: NotificationService.notifications.count > 0
  color: "transparent"
  implicitHeight: column.implicitHeight
  implicitWidth: layer.width
  anchors {
    right: true
    bottom: true
  }
  margins.bottom: 4
  margins.right: 4

  ListView {
    id: column
    implicitWidth: layer.width
    implicitHeight: contentHeight
    model: NotificationService.notifications

    delegate: Item {
      id: notification
      required property var modelData

      implicitWidth: box.width
      implicitHeight: box.height
      clip: true
      WrapperMouseArea {
        id: box
        acceptedButtons: Qt.RightButton
        onClicked: modelData.dismiss()
        hoverEnabled: true
        onEntered: modelData.expiring = false
        onExited: modelData.expiring = true
        width: 16 * 22
        // slide in-out animation
        x: width
        property bool show: !modelData.closing
        states: [
          State {
            name: "show"
            when: box.show
            PropertyChanges { target: box; x: 0 }
          },
          State {
            name: "hide"
            when: !box.show
            PropertyChanges { target: box; x: box.width }
          }
        ]
        transitions: [
          Transition {
            from: "*"; to: "*"
            NumberAnimation { properties: "x"; duration: modelData.closingDelay * 0.5; easing.type: Easing.OutCubic }
          },
          Transition {
            from: "show"; to: "hide"
            NumberAnimation { properties: "x"; duration: modelData.closingDelay; easing.type: Easing.InCubic }
          }
        ]

        ClippingWrapperRectangle {
          width: parent.width
          color: "#323130"
          radius: 10
          border {
            color: "transparent"
            width: 6
          }

          // Graphics starts here
          ColumnLayout {
            anchors.fill: parent
            spacing: 2
            Row {
              spacing: 6
              Layout.fillWidth: true
              topPadding: 6
              leftPadding: 8
              height: childrenRect.height
              WrapperRectangle {
                property var img: {
                  let image = modelData.image
                  if (modelData.appName === "niri") {
                    modelData.appIcon
                  } else if (image.startsWith('/')) {
                    "file://" + image
                  } else {
                    image
                  }
                }
                visible: img
                width: textCol.height
                height: textCol.height
                topMargin: 2
                color: "transparent"
                IconImage {
                  implicitSize: textCol.height
                  mipmap: true
                  source: parent.img
                }
              }
              Column {
                id: textCol
                width: parent.width * 0.75
                clip: true
                spacing: 2
                Text {
                  visible: modelData.summary
                  text: modelData.summary
                  color: "white"
                  font.pixelSize: 14
                  font.bold: true
                  // Plz wrap text!
                  width: parent.width
                  wrapMode: Text.WordWrap
                  elide: Text.ElideRight
                  maximumLineCount: 1
                }
                Text {
                  visible: modelData.body
                  text: modelData.body.replace(/\n/g, "<br>")
                  color: "white"
                  textFormat: Text.StyledText
                  // Plz wrap text!
                  width: parent.width
                  wrapMode: Text.WordWrap
                  elide: Text.ElideRight
                  font.pixelSize: 14
                  maximumLineCount: 3
                }
              }
            }
            // A rectangle that wraps both the underlying progress bar and the actual contents
            Rectangle {
              height: 24 + 2
              Layout.fillWidth: true
              Layout.topMargin: 6
              color: modelData.urgency == NotificationUrgency.Critical ? "#750b1c" : "#292827"
              Rectangle {
                id: progress
                height: parent.height
                width: 0
                color: "#55000000"
                Component.onCompleted: {
                  state = "end"
                  state = Qt.binding(function() { return modelData.expiring ? "end" : "begin" })
                }
                states: [
                  State { name: "begin"; PropertyChanges { target: progress; width: 0 } },
                  State { name: "end"; PropertyChanges { target: progress; width: parent.width } },
                ]
                transitions: [
                  Transition {
                    to: "end"
                    NumberAnimation { target: progress; properties: "width"; duration: modelData.timeout - 50 }
                  },
                  Transition {
                    to: "begin"
                    NumberAnimation { target: progress; properties: "width"; duration: 50 }
                  },
                ]
              }
              RowLayout {
                spacing: 4
                height: 24
                anchors.fill: parent
                anchors.leftMargin: 10
                anchors.rightMargin: 4
                anchors.bottomMargin: 2
                IconImage {
                  implicitSize: 18
                  visible: modelData.appIcon
                  source: {
                    let icon = modelData.appIcon
                    if (icon.startsWith('/')) {
                      "file://" + icon
                    } else {
                      icon
                    }
                  }
                }
                Text {
                  visible: !modelData.appIcon
                  text: "from"
                  color: "white"
                }
                Text {
                  text: modelData.appName
                  color: "white"
                }
                Item { Layout.fillWidth: true }
                Repeater {
                  model: modelData.actions
                  delegate: Button {
                    flat: true
                    implicitHeight: 24
                    icon: modelData.identifier
                    text: modelData.text
                    onClicked: modelData.invoke()
                  }
                }
              }
            }
          }
        }
      }
    }
  }
}
