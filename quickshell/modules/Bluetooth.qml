import Quickshell.Bluetooth
import QtQuick

Row {
  visible: Bluetooth.defaultAdapter
  spacing: 6
  anchors.verticalCenter: parent.verticalCenter

  property var connected: Bluetooth.devices.values.filter((d) => d.connected)

  Text {
    visible: connected.length === 0
    text: Bluetooth.defaultAdapter.enabled ? "\uf294" : "\udb80\udcb2"
    font: root.fontSymbol
    color: "white"
  }

  Repeater {
    model: connected
    Text {
      text: model.batteryAvailable ? "\udb82\udd49" : "\udb80\udcb1"
      font: root.fontSymbol
      color: "white"
    }
  }
}
