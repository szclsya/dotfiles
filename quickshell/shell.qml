//@ pragma UseQApplication
import Quickshell
import QtQuick
import Niri 0.1
import "./modules/"
import "./services/"

Scope {
  id: root

  // globals
  property font font: Qt.font({
    family: "monospace",
    pixelSize: 14,
    color: "white",
  })
  property font fontPixel: Qt.font({
    family: "Ark Pixel 12px Mono zh_cn",
    pixelSize: 14,
    color: "white"
  })
  property font fontSymbol: Qt.font({
    family: "Symbols Nerd Font",
    pixelSize: 16,
    color: "white"
  })
  property int height: 24
  property var networks: ["wlan0", "enp17s0f1np1"]

  Variants {
    model: Quickshell.screens
    delegate: Bar {}
  }

  Niri {
    id: niri
    Component.onCompleted: connect()
    onConnected: console.log("Niri: Connected")
    onErrorOccurred: function(error) { console.error("Niri error: ", error) }
  }

  //PipewireService {}
}
