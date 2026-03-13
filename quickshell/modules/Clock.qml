import QtQuick
import Quickshell

Rectangle {
  width: clockText.width
  height: clockText.height
  color: "transparent"
  anchors.fill: parent

  property var font: root.font

  SystemClock {
    id: clock
    precision: SystemClock.Seconds
  }

  Text {
    id: clockText
    text: Qt.formatDateTime(clock.date, "MM-dd ddd hh:mm:ss")
    anchors {
      //right: parent.right
      verticalCenter: parent.verticalCenter
    }
    font.pixelSize: 16
    font.family: root.fontPixel.family
    padding: 8
    color: "white"
  }
}
