pragma Singleton

import QtQuick
import Quickshell
import Quickshell.Io

Singleton {
  property bool redact: false
  readonly property var config: JSON.parse(configJson.text())
  readonly property var networks: config["networks"].map(n => { return { interface: n }})
  readonly property string clock_format: config["clock_format"] ?? "MM-dd ddd hh:mm:ss"
  readonly property var backlight: config["backlight"]

  FileView {
    id: configJson
    path: Quickshell.shellDir + "/config.json"
    blockLoading: true
  }

  IpcHandler {
    target: "global"
    function redactOn(): void  { Config.redact = true }
    function redactOff(): void  { Config.redact = false }
    function redactToggle(): void { Config.redact = !Config.redact }
  }
}
