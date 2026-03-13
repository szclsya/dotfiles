import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Wayland

Rectangle {
  width: row.width
  height: row.height
  color: "#993b3a39"
  Layout.fillHeight: true
  radius: 50

  RowLayout {
    id: row
    spacing: 0

    Repeater {
      model: niri.workspaces
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
          onClicked: niri.focusWorkspaceById(model.id)
        }
      }
    }
  }
}
