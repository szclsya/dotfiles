import QtCore
import QtQuick
import Qt.labs.folderlistmodel
import Quickshell
import Quickshell.Wayland

import qs.Services

Scope {
  property url wallpaper_path
  FolderListModel {
    id: wallpapers
    folder: StandardPaths.writableLocation(StandardPaths.HomeLocation) + "/" + (Config.wallpaper_path || "Pictures/Wallpaper")
    showDirs: false
    nameFilters: [ "*.png", "*.jpg" ]
    onCountChanged: random()
    function random() {
      if (wallpapers.count === 0) return null
      let i = Math.floor(Math.random() * wallpapers.count)
      wallpaper_path = wallpapers.get(i, "fileUrl")
    }
  }

  Variants {
    model: Quickshell.screens

    PanelWindow {
      WlrLayershell.layer: WlrLayer.Background
      required property var modelData
      screen: modelData
      anchors {
        top: true
        right: true
        bottom: true
        left: true
      }
      exclusionMode: ExclusionMode.Ignore
      // Default fallback
      color: "black"
      Image {
        anchors.fill: parent
        source: wallpaper_path
      }
    }
  }
}
