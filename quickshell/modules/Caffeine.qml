import QtQuick
import Quickshell.Wayland
import Quickshell.Widgets
import qs.services

WrapperMouseArea {
  onClicked: CaffeineService.toggle()

  Text {
    text: CaffeineService.enabled() ? "\udb81\udeca" : "\udb83\udfab"
    font.family: root.fontSymbol.family
    font.pixelSize: 15
    color: "white"
  }
}
