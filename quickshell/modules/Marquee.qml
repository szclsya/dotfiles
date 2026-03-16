import QtQuick

Item {
  id: marquee
  property string text: ""
  property string spacing: "      "
  property int max_len: 16
  property string combined: text + spacing
  property string display: step + max_len > combined.length
    ? combined.substring(step) + combined.substring(0, step + max_len - combined.length)
    : combined.substring(step, step + max_len)
  property int step: 0
  property font font: root.font
  property color color: "white"

  implicitWidth: innertext.width

  function reset() {
    step = 0
  }

  Timer {
    interval: 500
    running: tm.tightBoundingRect.width < font.pixelSize * max_len
    repeat: true
    onTriggered: parent.step = (parent.step + 1) % parent.combined.length
  }

  Text {
    id: innertext
    anchors.verticalCenter: parent.verticalCenter
    text: tm.tightBoundingRect.width < font.pixelSize * max_len ? parent.display : parent.text
    font: parent.font
    color: parent.color

    width: font.pixelSize * max_len / 2
    clip: true
    maximumLineCount: 1
  }

  TextMetrics {
    id: tm
    font: marquee.font
    text: marquee.text
  }
}
