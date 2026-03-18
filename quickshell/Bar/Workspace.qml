import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Wayland
import Quickshell.Widgets
import qs.Services

Row {
  spacing: 0

  Repeater {
    model: Niri.niri.workspaces
    Rectangle {
      visible: index < 11 && model.output === screen.name
      width: bar.height
      radius: 100
      height: bar.height
      color: model.isActive ? "white" : "transparent"
      Text {
        anchors.verticalCenter: parent.verticalCenter
        anchors.horizontalCenter: parent.horizontalCenter
        text: model.index
        color: model.isActive ? "black" : "white"
        font: bar.font
      }
      MouseArea {
        anchors.fill: parent
        acceptedButtons: Qt.LeftButton
        onClicked: Niri.niri.focusWorkspaceById(model.id)
      }
    }
  }
}
