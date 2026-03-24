pragma Singleton

import Quickshell
import Quickshell.Services.Notifications

Singleton {
  //readonly property int count: server.trackedNotifications.values.count
  readonly property var notifications: server.trackedNotifications
  NotificationServer {
    id: server
    imageSupported: true
    actionsSupported: true
    bodyMarkupSupported: true
    onNotification: (notification) => {
      notification.tracked = true
    }
  }
}
