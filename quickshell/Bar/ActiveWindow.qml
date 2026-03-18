import QtQuick
import QtQuick.Layouts

import qs.Services

Row {
  property var max_len: Config.modules["ActiveWindow"] ? Config.modules["ActiveWindow"]["max_len"] : 20
  spacing: 4
  anchors.verticalCenter: parent.verticalCenter

  Image {
    source: Niri.niri.focusedWindow?.iconPath ? "file://" + Niri.niri.focusedWindow.iconPath : ""
    sourceSize.width: bar.height * 0.66
    sourceSize.height: bar.height * 0.66
    width: bar.height * 0.66
    smooth: true
    anchors.verticalCenter: parent.verticalCenter
  }

  Text {
    text: Niri.niri.focusedWindow?.title ?? "Empty Workspace"
    color: "white"
    font: bar.font
    //width: parent.max_len * font.pixelSize
    width: bar.width * 0.15
    elide: Text.ElideRight
    anchors.verticalCenter: parent.verticalCenter
  }

  Text {
    // Just a spacer
    text: " "
  }
}
