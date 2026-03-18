import QtQuick
import Quickshell.Wayland
import Quickshell.Widgets
import qs.Services

WrapperRectangle {
  height: parent.height
  color: "transparent"
  WrapperMouseArea {
    onClicked: CaffeineService.toggle()
    resizeChild: false
    Text {
      text: CaffeineService.enabled() ? "\udb81\udeca" : "\udb83\udfab"
      font.family: bar.fontSymbol.family
      font.pixelSize: 15
      color: "white"
      height: parent.height
    }
  }
}
