import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Wayland

Rectangle {
  width: row.width
  RowLayout {
    id: row
    spacing: 0
    Repeater {
      model: niri.workspaces
      Rectangle {
        visible: index < 11 && model.output === screen.name
        width: 24
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
          onClicked: niri.focusWorkspaceById(model.id)
        }
      }
    }
  }
}
