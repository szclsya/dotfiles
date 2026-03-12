import QtQuick
import Quickshell

Rectangle {
  width: block.width
  SystemClock {
    id: clock
    precision: SystemClock.Seconds
  }

  Text {
    id: block
    text: Qt.formatDateTime(clock.date, "yyyy-MM-dd ddd hh:mm:ss")
    anchors {
      right: parent.right
      verticalCenter: parent.verticalCenter
    }
    font: root.font
    color: "white"
  }
}
