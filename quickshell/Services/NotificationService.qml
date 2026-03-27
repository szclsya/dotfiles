pragma Singleton

import QtQuick
import Quickshell
import Quickshell.Services.Notifications

Singleton {
  id: root
  property var notifications: ListModel {}

  NotificationServer {
    id: server
    imageSupported: true
    actionsSupported: true
    bodyMarkupSupported: true
    // We are currently volatile
    keepOnReload: false
    onNotification: (notification) => {
      notification.tracked = true
      let model = notificationWrapper.createObject(notification, {
        "notification": notification
      })

      model.onClosed.connect(() => {
        for (let i = 0; i < root.notifications.count; i++) {
          if (root.notifications.get(i).modelData === model) {
            root.notifications.remove(i); break
          }
        }
      })

      root.notifications.append({ modelData: model })
    }
  }

  // Helper, doesn't serve a purpose
  Component {
    id: notificationWrapper
    NotificationModel {}
  }

  component NotificationModel: QtObject {
    id: nm
    required property Notification notification

    property var id: notification.id
    property bool expiring: true
    property bool userDismiss: false
    readonly property int closingDelay: 200
    property bool closing: false
    property int timeout: notification.expireTimeout > 0 ? notification.expireTimeout : 5000
    signal closed()
    function dismiss() {
      nm.closing = true || notification.dismiss()
    }
    property Connections c: Connections {
      target: nm.notification
      function onClosed() {
        nm.closing = true
      }
    }
    property Timer expireTimer: Timer {
      running: expiring
      interval: timeout
      onTriggered: nm.closing = true || notification.expire()
    }
    property Timer destroyTimer: Timer {
      running: nm.closing
      interval: closingDelay * 2
      onTriggered: nm.closed()
    }
    // Re-exports
    property var summary: notification.summary ?? ""
    property var body: notification.body ?? ""
    property var urgency: notification.urgency ?? 0
    property var image: notification.image ?? ""
    property var appIcon: notification.appIcon ?? ""
    property var appName: notification.appName ?? ""
    property var actions: notification.actions ?? ""
  }
}
