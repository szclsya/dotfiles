import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Wayland
import Quickshell.Widgets
import qs.Services

Item {
  id: root
  implicitHeight: bar.height
  implicitWidth: row.implicitWidth

  // Highlight pill that glides to the active workspace.
  // Its x is written by the active cell's Binding below.
  Rectangle {
    id: pill
    width: bar.height
    height: bar.height
    radius: 100
    color: "white"
    // Hidden while there are no cells for this output (empty model,
    // other screen's workspaces, or the >11 cutoff).
    visible: row.implicitWidth > 0
    Behavior on x {
      NumberAnimation {
        duration: 100
        easing.type: Easing.InOutCubic
      }
    }
  }

  Row {
    id: row
    spacing: 0

    Repeater {
      model: Niri.niri.workspaces
      Rectangle {
        id: cell
        required property var model
        required property int index
        readonly property bool isActive: model.isActive
        visible: index < 11 && model.output === screen.name
        width: bar.height
        height: bar.height
        color: "transparent"

        // The active cell hands its layout position to the pill.
        // Row skips invisible cells when laying out, so cell.x is
        // already the correct pixel offset; no index arithmetic needed.
        Binding {
          target: pill
          property: "x"
          value: cell.x
          when: cell.isActive && cell.visible
          restoreMode: Binding.RestoreNone
        }

        Text {
          anchors.verticalCenter: parent.verticalCenter
          anchors.horizontalCenter: parent.horizontalCenter
          text: model.index
          color: cell.isActive ? "black" : "white"
          font: bar.font
          Behavior on color {
            ColorAnimation {
              duration: 50
            }
          }
        }
        MouseArea {
          anchors.fill: parent
          acceptedButtons: Qt.LeftButton
          onClicked: Niri.niri.focusWorkspaceById(model.id)
        }
      }
    }
  }
}
