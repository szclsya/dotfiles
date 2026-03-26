pragma Singleton

import QtQuick
import Quickshell
import Quickshell.Services.Notifications

Singleton {
  id: root
  //readonly property var notifications: server.trackedNotifications
  property var states: states
  property var notifications: ListModel {}

  NotificationServer {
    id: server
    imageSupported: true
    actionsSupported: true
    bodyMarkupSupported: true
    onNotification: (notification) => {
      notification.tracked = true
      let model = notificationWrapper.createObject(notification, {
        "notification": notification
      })

      model.onClosedChanged.connect(() => {
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
    property bool closed: false
    property int timeout: notification.expireTimeout > 0 ? notification.expireTimeout : 5000
    signal closed()
    property var lock: RetainableLock {
      object: notification
      locked: true
    }
    function dismiss() {
      nm.closed || notification.dismiss()
    }
    property Connections c: Connections {
      target: nm.notification
      function onClosed() {
        nm.closing = true
        destroyTimer.start()
      }
    }
    property Timer expireTimer: Timer {
      running: expiring
      interval: timeout
      onTriggered: nm.closed || notification.expire()
    }
    property Timer destroyTimer: Timer {
      interval: closingDelay * 2
      onTriggered: nm.closed = true
    }
    // Re-exports
    property var summary: notification.summary
    property var body: notification.body
    property var urgency: notification.urgency
    property var image: notification.image
    property var appIcon: notification.appIcon
    property var appName: notification.appName
    property var actions: notification.actions
  }
}
