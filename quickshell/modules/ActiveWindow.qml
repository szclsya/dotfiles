import QtQuick

Row {
  property var max_len: 25

  spacing: 4
  height: parent.height
  width: root.font.pixelSize * max_len

  Image {
    id: img
    source: niri.focusedWindow?.iconPath ? "file://" + niri.focusedWindow.iconPath : ""
    sourceSize.width: root.height * 0.6
    sourceSize.height: root.height * 0.6
    width: root.height * 0.6
    anchors.verticalCenter: parent.verticalCenter
    smooth: true
  }

  Text {
    id: txt
    anchors.verticalCenter: parent.verticalCenter
    text: niri.focusedWindow?.title ?? "  Empty Workspace"
    color: "white"
    font: root.fontPixel
    width: root.font.pixelSize * (parent.max_len - 1)
    clip: true
  }
}
