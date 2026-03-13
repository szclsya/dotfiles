import QtQuick

Item {
  property string text: ""
  property string spacing: "      "
  property int max_len: 25
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
    running: text.length > max_len
    repeat: true
    onTriggered: parent.step = (parent.step + 1) % parent.combined.length
  }

  Text {
    id: innertext
    anchors.verticalCenter: parent.verticalCenter
    text: combined.length > max_len ? parent.display : parent.text
    font: parent.font
    color: parent.color

    // Latin characters are half width
    width: font.pixelSize * max_len / 2
    clip: true
    maximumLineCount: 1
  }
}
