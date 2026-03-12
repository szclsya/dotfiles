import QtQuick
import QtQuick.Layouts
import Quickshell

PanelWindow {
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
    gradient: Gradient {
      GradientStop { position: 0.0; color: "#00000000" }
      GradientStop { position: 1.0; color: "#88000000" }
    }
    // Left
    RowLayout {
      anchors {
        left: parent.left
      }
      Workspace {}
    }
    // Middle
    RowLayout {
      spacing: 10
      anchors {
        horizontalCenter: parent.horizontalCenter
        verticalCenter: parent.verticalCenter
      }
      Marquee {
        text: "abcdefghijklmnopqrstuvwxyz1234567890"
        max_len: 30
      }
      Text {
        text: niri.focusedWindow?.title ?? ""
        color: "white"
        font: root.font
      }
      Player {}
    }
    // Right
    RowLayout {
      anchors {
        right: parent.right
        verticalCenter: parent.verticalCenter
      }
      Clock {}
    }
  }
}
