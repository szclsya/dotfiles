import QtQuick
import QtQuick.Layouts
import Quickshell.Widgets

import qs.Services

WrapperRectangle {
  color: "transparent"
  topRightRadius: 50
  bottomRightRadius: 50
  height: bar.height
  property int activeWindowId: Niri.niri.activeWindowId(bar.screen.name)

  Connections {
    target: Niri.niri
    onFocusedWindowChanged: activeWindowId = Niri.niri.activeWindowId(bar.screen.name)
  }

  SortFilterProxyModel {
    id: activeWindowProxy
    model: Niri.niri.windows
    filters: [
      ValueFilter {
        roleName: "id"
        value: activeWindowId ?? 0
      }
    ]
  }

  Row {
    id: activeWindowRow
    Repeater {
      id: activeWindow
      model: activeWindowProxy
      delegate: WrapperRectangle {
        color: activeWindowId === Niri.niri.focusedWindow.id ? "#ff017371" : "#551b1a19"
        Behavior on color {
            ColorAnimation { duration: 100 }
        }
        topRightRadius: 50
        bottomRightRadius: 50
        height: bar.height
        Row {
          leftPadding: bar.height/4*3
          spacing: 6
          anchors.verticalCenter: parent.verticalCenter

          Image {
            source: model.iconPath ? "file://" + model.iconPath : ""
            sourceSize.width: bar.height * 0.66
            sourceSize.height: bar.height * 0.66
            width: bar.height * 0.66
            smooth: true
            anchors.verticalCenter: parent.verticalCenter
          }

          Text {
            text: model.title ?? "Empty Workspace"
            color: "white"
            font: bar.font
            height: bar.height
            verticalAlignment: Text.AlignVCenter
            width: bar.width * 0.15
            elide: Text.ElideRight
            rightPadding: 8
          }
        }
      }
    }

    // Empty
    WrapperRectangle {
      width: bar.height/4*3 + bar.width * 0.15 + bar.height * 0.66 + 6
      color: "#881b1a19"
      visible: activeWindow.count === 0
      height: bar.height
      topRightRadius: 50
      bottomRightRadius: 50

      Text {
        leftPadding: bar.height
        text: "Empty Workspace"
        color: "white"
        font: bar.font
        elide: Text.ElideRight
        height: bar.height
        verticalAlignment: Text.AlignVCenter
      }
    }
  }
}
