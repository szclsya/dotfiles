pragma Singleton

import QtQuick
import Quickshell
import Quickshell.Io
import qs.Services

Singleton {
  id: backlightService
  readonly property bool enabled: Config.backlight !== ""
  readonly property int brightness_raw: enabled ? (parseInt(current.data()) || 0) : 0
  readonly property int max_brightness_raw: enabled ? (parseInt(max.data()) || 0) : 0
  readonly property real brightness: max_brightness_raw > 0 ? brightness_raw / max_brightness_raw : 0

  FileView {
    id: current
    path: "/sys/class/backlight/" + Config.backlight + "/brightness"
    watchChanges: true
    preload: backlightService.enabled
    onFileChanged: this.reload()
    // when backlight gets enabled at runtime (Config reload), kick a load
    onPreloadChanged: if (preload) reload()
  }

  FileView {
    id: max
    path: "/sys/class/backlight/" + Config.backlight + "/max_brightness"
    watchChanges: true
    preload: backlightService.enabled
    onFileChanged: this.reload()
    onPreloadChanged: if (preload) reload()
  }
}
