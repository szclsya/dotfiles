pragma Singleton

import QtQuick
import Quickshell
import Quickshell.Io

Singleton {
  readonly property int brightness_raw: parseInt(current.data())
  readonly property int max_brightness_raw: parseInt(max.data())
  readonly property real brightness: brightness_raw / max_brightness_raw

  function set(target) {
    current.setText(target * max_brightness_raw)
    //current.reload()
  }

  FileView {
    id: current
    path: "/sys/class/backlight/intel_backlight/brightness"
    watchChanges: true
    onFileChanged: this.reload()
  }

  FileView {
    id: max
    path: "/sys/class/backlight/intel_backlight/max_brightness"
    watchChanges: true
    onFileChanged: this.reload()
  }
}
