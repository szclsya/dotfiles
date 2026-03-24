import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import Quickshell
import Quickshell.Widgets
import Quickshell.Wayland
import qs.Services

PanelWindow {
  id: layer
  required property var modelData
  screen: modelData
  // 22em
  readonly property int width: 16 * 22
  readonly property int height: width * 0.4

  WlrLayershell.namespace: "qs-notifications-" + (screen?.name || "unknown")
  color: "transparent"
  visible: NotificationService.notifications.values.length > 0
  implicitHeight: column.implicitHeight
  implicitWidth: layer.width
  anchors {
    right: true
    bottom: true
  }

  ListView {
    id: column
    implicitWidth: layer.width
    implicitHeight: contentHeight
    model: NotificationService.notifications
    delegate: Item {
      implicitWidth: notificationPanel.width
      implicitHeight: notificationPanel.height
      clip: true
      ClippingWrapperRectangle {
        id: notificationPanel
        width: 16 * 22
        color: "#323130"
        //margin: 16
        radius: 10
        border {
          color: "transparent"
          width: 6
        }
        // slide in-out animation
        property bool show: false
        Component.onCompleted: notificationPanel.show = true
        x: 200
        states: [
          State {
            name: "show"
            when: notificationPanel.show
            PropertyChanges { target: notificationPanel; x: 0 }
          },
          State {
            name: "hide"
            when: !notificationPanel.show
            PropertyChanges { target: notificationPanel; x: notificationPanel.width }
          }
        ]
        transitions: [
          Transition {
            from: "*"; to: "*"
            NumberAnimation { properties: "x"; duration: 150; easing.type: Easing.OutCubic }
          },
          Transition {
            from: "show"; to: "hide"
            NumberAnimation { properties: "x"; duration: 200; easing.type: Easing.InCubic }
          }
        ]
        // auto-expire
        Timer {
          id: expire
          running: true
          repeat: false
          interval: modelData.expireTimeout > 0 ? modelData.expireTimeout : 5000
          onTriggered: { notificationPanel.show = false; expireAnimation.running = true }
        }
        Timer {
          id: expireAnimation
          running: false
          repeat: false
          interval: 200
          onTriggered: { notificationPanel.implicitHeight = 1; expireFinal.running = true }
        }
        Timer {
          id: expireFinal
          running: false
          repeat: false
          interval: 100
          onTriggered: { modelData.expire() }
        }
        Connections {
          target: modelData
          onImageChanged: expire.restart()
          onSummaryChanged: expire.restart()
          onBodyChanged: expire.restart()
          onActionsChanged: expire.restart()
        }

        // Graphics starts here
        ColumnLayout {
          anchors.fill: parent
          spacing: 2
          Row {
            spacing: 6
            Layout.fillWidth: true
            topPadding: 8
            leftPadding: 8
            height: childrenRect.height
            IconImage {
              visible: modelData.image
              implicitSize: parent.width * 0.2
              mipmap: true
              source: {
                let icon = modelData.image
                if (icon.startsWith('/')) {
                  "file://" + icon
                } else {
                  icon
                }
              }
            }
            Column {
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
          RowLayout {
            spacing: 4
            height: 24
            Layout.topMargin: 4
            Layout.leftMargin: 8
            Layout.bottomMargin: 4

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
