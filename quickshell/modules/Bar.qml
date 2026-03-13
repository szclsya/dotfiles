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
    //top: true
    right: true
    bottom: true
    left: true
  }

  Rectangle {
    anchors.fill: parent
    color: "transparent"
    // Left
    RowLayout {
      Layout.alignment: Qt.AlignLeft

      Workspace {}
    }
    // Middle
    Rectangle {
      anchors {
        horizontalCenter: parent.horizontalCenter
        horizontalCenterOffset: -80
      }
      height: parent.height
      //implicitWidth: 2 + middleLeft.width + 8 + middleCenter.width + 8 + middleRight.width + 16
      width: childrenRect.width + 8
      radius: 50
      color: "#bb3b3a39"

      Rectangle {
        id: middleLeft
        anchors.right: middleCenter.left
        anchors.rightMargin: 8
        height: parent.height
        implicitWidth: childrenRect.width
        color: "transparent"
        ActiveWindow { max_len: 16 }
      }
      Rectangle {
        id: middleCenter
        anchors {
          horizontalCenter: parent.horizontalCenter
        }
        color: "#cc1b1a19"
        radius: 50
        implicitWidth: centerClock.width
        height: root.height
        Clock {
          id: centerClock
        }
      }
      Rectangle {
        id: middleRight
        anchors.left: middleCenter.right
        anchors.leftMargin: 8
        height: root.height
        implicitWidth: childrenRect.width
        color: "transparent"

        Player { id: mprisPlayer }
      }
    }
    // Right
    RowLayout {
      id: right
      height: parent.height
      anchors {
        right: parent.right
        verticalCenter: parent.verticalCenter
      }
      Rectangle {
        color: "#7c1d21"
        radius: 50
        height: root.height
        width: childrenRect.width

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
        width: childrenRect.width

        Row {
          padding: 10
          anchors.verticalCenter: parent.verticalCenter
          Bluetooth {}
          Text { text: "bruh" }
        }
      }
      Rectangle {
        color: "#986f0b"
        radius: 50
        height: root.height
        width: childrenRect.width

        Row {
          padding: 10
          anchors.verticalCenter: parent.verticalCenter
          Caffeine {}
        }
      }
      // TODO volume, wifi/ethernet, bluetooth, caffeine, brightness, power, tray
    }
  }
}
