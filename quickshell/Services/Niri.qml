pragma Singleton
import QtQuick
import Quickshell
import Niri 0.1

Singleton {
  readonly property Niri niri: niri
  Niri {
    id: niri
    Component.onCompleted: connect()
    onErrorOccurred: function(error) { console.error("Niri error: ", error) }
  }
}
