import QtQuick
import Quickshell.Wayland
import Quickshell.Widgets
import qs.services

WrapperMouseArea {
  onClicked: CaffeineService.toggle()

  Text {
    anchors.verticalCenter: parent.verticalCenter
    text: CaffeineService.enabled() ? "\udb81\udeca" : "\udb83\udfab"
    font: root.fontSymbol
    color: "white"
  }
}
