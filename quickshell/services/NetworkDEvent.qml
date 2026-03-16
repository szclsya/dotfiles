pragma Singleton

import QtQuick
import Quickshell
import Quickshell.Io

Singleton {
  id: netevent
  signal networkChanged

  Timer {
    id: delayTimer
    interval: 500
    running: false
    repeat: false
    onTriggered: netevent.networkChanged()
  }

  Process {
    id: netevent_process
    property var lastread: Date.now()
    running: true
    command: ["dbus-monitor", "--system", "sender='org.freedesktop.network1'"]
    stdout: SplitParser {
      onRead: {
        if ((Date.now() - netevent_process.lastread) > 100) {
          netevent.networkChanged()
          delayTimer.running = true
        }
        netevent_process.lastread = Date.now()
      }
    }
  }
}
