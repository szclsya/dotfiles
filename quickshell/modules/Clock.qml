import QtQuick
import Quickshell

Rectangle {
  width: childrenRect.width
  height: root.height
  color: "transparent"
  //color: "green"
  anchors.verticalCenter: parent.verticalCenter

  property var font: root.font

  SystemClock {
    id: clock
    precision: SystemClock.Seconds
  }

  Text {
    id: clockText
    text: Qt.formatDateTime(clock.date, "MM-dd ddd hh:mm:ss")
    font.pixelSize: 15
    font.family: root.fontPixel.family
    anchors.verticalCenter: parent.verticalCenter
    padding: 8
    color: {
      if (clock.minutes === 59 && clock.seconds > 50 && clocks.seconds % 2 === 0) {
        "transparent"
      } else {
        "white"
      }
    }
  }
}
