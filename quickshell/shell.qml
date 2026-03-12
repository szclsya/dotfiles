import Quickshell
import QtQuick
import Niri 0.1
import "./modules/"

Scope {
  id: root
  // globals
  property font font: Qt.font({
    family: "monospace",
    pixelSize: 14,
    color: "white",
  })
  property int height: 24

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

  //property ObjectModel<Toplevel> toplevels: ToplevelManager.toplevels
}
