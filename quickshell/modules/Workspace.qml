import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Wayland
import Quickshell.Widgets
import qs.services

Row {
  spacing: 0

  Repeater {
    model: Niri.niri.workspaces
    Rectangle {
      visible: index < 11 && model.output === screen.name
      width: 24
      radius: 50
      height: root.height
      color: model.isActive ? "white" : "transparent"
      Text {
        anchors.verticalCenter: parent.verticalCenter
        anchors.horizontalCenter: parent.horizontalCenter
        text: model.index
        color: model.isActive ? "black" : "white"
        font: root.font
      }
      MouseArea {
        anchors.fill: parent
        acceptedButtons: Qt.LeftButton
        onClicked: niri.focusWorkspaceById(model.id)
      }
    }
  }
}
