import QtQuick
import Quickshell
import qs.Services

Rectangle {
  width: childrenRect.width
  height: bar.height
  color: "transparent"
  anchors.verticalCenter: parent.verticalCenter

  property var font: bar.font
  property var format: Config.modules["Clock"] ? Config.modules["Clock"]["format"] : "MM-dd ddd hh:mm:ss"

  SystemClock {
    id: clock
    precision: SystemClock.Seconds
  }

  Text {
    id: clockText
    text: Qt.formatDateTime(clock.date, format)
    font: bar.fontPixel
    anchors.verticalCenter: parent.verticalCenter
    padding: 8
    color: {
      if (clock.minutes === 59 && clock.seconds > 45 && clock.seconds % 2 === 0) {
        "transparent"
      } else {
        "white"
      }
    }
  }
}
