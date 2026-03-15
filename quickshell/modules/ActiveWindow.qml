import QtQuick
import QtQuick.Layouts

Row {
  property var max_len: 10

  spacing: 4
  height: parent.height

  Image {
    source: niri.focusedWindow?.iconPath ? "file://" + niri.focusedWindow.iconPath : ""
    sourceSize.width: root.height * 0.66
    sourceSize.height: root.height * 0.66
    width: root.height * 0.66
    smooth: true
  }

  Text {
    text: niri.focusedWindow?.title ?? "Empty Workspace"
    color: "white"
    font: root.font
    width: max_len * font.pixelSize
    elide: Text.ElideRight
  }

  Text {
    // Just a spacer
    text: " "
  }
}
