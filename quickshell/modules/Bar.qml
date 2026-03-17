import QtQuick
import QtQuick.Layouts
import Quickshell

PanelWindow {
  id: panel
  required property var modelData
  screen: modelData
  implicitHeight: 24
  color: "transparent"
  anchors {
    right: true
    bottom: true
    left: true
  }

  Rectangle {
    anchors.fill: parent
    color: "transparent"

    // Left
    Rectangle {
      height: parent.height
      width: childrenRect.width
      radius: 50
      color: "#661b1a19"

      RowLayout {
        Layout.alignment: Qt.AlignLeft

        Workspace {}
        ActiveWindow {}
      }
    }
    // Right
    Rectangle {
      height: parent.height
      width: childrenRect.width
      radius: 50
      color: "transparent"
      anchors {
        right: parent.right
        verticalCenter: parent.verticalCenter
      }

      Row {
        id: right
        height: parent.height
        spacing: 2
        Rectangle {
          color: "#881b1a19"
          radius: 50
          height: root.height
          implicitWidth: childrenRect.width + root.height

          Player { id: mprisPlayer; anchors.horizontalCenter: parent.horizontalCenter }
        }
        Rectangle {
          color: "#7c1d21"
          radius: 50
          height: root.height
          implicitWidth: childrenRect.width
          Row {
            padding: 10
            anchors.verticalCenter: parent.verticalCenter
            Pipewire {}
          }
        }
        Rectangle {
          color: "#004e8c"
          radius: 50
          height: root.height
          implicitWidth: childrenRect.width
          //width: 265
          Row {
            padding: 10
	        spacing: 8
            anchors.verticalCenter: parent.verticalCenter
            Bluetooth {}
            Network {}
          }
        }
        Rectangle {
          color: "#986f0b"
          radius: 50
          height: root.height
          width: childrenRect.width
          Row {
            padding: 10
	        spacing: 8
            anchors.verticalCenter: parent.verticalCenter
            Caffeine {}
	        Backlight {}
	        Battery {}
          }
        }
        Rectangle {
          color: "#661b1a19"
          radius: 50
          height: root.height
          implicitWidth: childrenRect.width
          Row {
            spacing: 6
            SystemTray {}
            Rectangle {
              height: root.height
              implicitWidth: childrenRect.width
              color: "#881b1a19"
              radius: 50
              Clock {}
            }
          }
        }
        // TODO wifi/ethernet, brightness, power
      }
    }
  }
}
