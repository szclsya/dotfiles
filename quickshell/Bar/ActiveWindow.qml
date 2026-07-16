import QtQuick
import QtQuick.Layouts
import Quickshell.Widgets

import qs.Services

Row {
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

  Repeater {
    id: activeWindow
    model: activeWindowProxy
    delegate: Row {
      spacing: 4
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
        width: bar.width * 0.15
        elide: Text.ElideRight
        anchors.verticalCenter: parent.verticalCenter
      }
    }
  }

  // Empty
  Text {
    visible: activeWindow.count === 0
    text: "Empty Workspace"
    color: "white"
    font: bar.font
    width: bar.width * 0.15 + bar.height * 0.66
    elide: Text.ElideRight
    anchors.verticalCenter: parent.verticalCenter
  }

  Text {
    // Just a spacer
    text: " "
  }
}
