pragma Singleton

import QtQuick
import Quickshell
import Quickshell.Services.Notifications

Singleton {
  readonly property var notifications: server.trackedNotifications
  property var states: states

  NotificationServer {
    id: server
    imageSupported: true
    actionsSupported: true
    bodyMarkupSupported: true
    onNotification: (notification) => { notification.tracked = true }
  }

  Instantiator {
    id: states
    model: server.trackedNotifications
    delegate: Scope {
      property var id: modelData.id
      property bool expiring: true
      property bool userDismiss: false
      readonly property int closingDelay: 200
      property bool closing: false
      property bool closed: false
      property int timeout: modelData.expireTimeout > 0 ? modelData.expireTimeout : 5000
      function dismiss() {
        this.userDismiss = true
        closingTimer.restart()
      }
      Timer {
        running: expiring
        interval: timeout
        onTriggered: { closing = true; closingTimer.restart() }
      }
      Timer {
        id: closingTimer
        interval: closingDelay
        onTriggered: closed = true
      }
      // Have a delay until we dismiss the message
      Timer {
        running: closed
        interval: 100
        onTriggered: {
          if (this.userDismiss) {
            modelData.dismiss()
          } else {
            modelData.expire()
          }
        }
      }
    }
  }
}
