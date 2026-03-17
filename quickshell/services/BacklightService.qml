pragma Singleton

import QtQuick
import Quickshell
import Quickshell.Io
import qs.services

Singleton {
  id: backlightService
  readonly property bool enabled: Config.backlight
  readonly property int brightness_raw: parseInt(current.data())
  readonly property int max_brightness_raw: parseInt(max.data())
  readonly property real brightness: brightness_raw / max_brightness_raw

  Component.onCompleted: enabled ? loader.active = true : loader.active = false
  Loader {
    id: loader
    FileView {
      id: current
      path: "/sys/class/backlight/" + Config.backlight +"/brightness"
      watchChanges: true
      onFileChanged: this.reload()
    }

    FileView {
      id: max
      path: "/sys/class/backlight/" + Config.backlight +"/max_brightness"
      watchChanges: true
      onFileChanged: this.reload()
    }
  }
}
