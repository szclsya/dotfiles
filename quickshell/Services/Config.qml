pragma Singleton

import QtQuick

import Quickshell
import Quickshell.Io

Singleton {
  readonly property var config: JSON.parse(configJson.text())
  property bool redact: false
  readonly property var networks: config["networks"].map(n => { return { interface: n }})
  readonly property var backlight: config["backlight"]
  readonly property var modules: config["modules"]

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
