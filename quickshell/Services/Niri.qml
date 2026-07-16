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
    function activeWindowId(screen) {
      for (let i = 0; i < niri.workspaces.count; i++) {
        const ws = niri.workspaces.get(i)
        if (ws.output === screen && ws.isActive) {
          return ws.activeWindowId
        }
      }
      return null
    }
  }
}
