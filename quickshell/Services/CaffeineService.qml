pragma Singleton

import Quickshell
import Quickshell.Wayland
import QtQuick

Singleton {
  id: root

  function enabled() {
    return persist.isEnabled;
  }

  function toggle() {
    persist.isEnabled = !persist.isEnabled;
  }

  PersistentProperties {
    id: persist
    reloadableId: "persistedStates"
    property bool isEnabled: false
  }

  IdleInhibitor {
    enabled: persist.isEnabled
    window: PanelWindow {
      implicitWidth: 0
      implicitHeight: 0
      color: "transparent"
      WlrLayershell.namespace: "qs-idle-inhibitor"
      mask: Region {}
    }
  }
}
