import Quickshell.Services.Pipewire
import QtQuick
import QtQuick.Layouts
import Quickshell.Widgets

// Using a rect here bc icons are not monospace
RowLayout {
  height: root.height
  width: root.font.pixelSize * 4.5
  clip: true

  property var source: Pipewire.defaultAudioSource
  property var sink: Pipewire.defaultAudioSink

  WrapperMouseArea {
    onClicked: source.audio.muted = !source.audio.muted
    Text {
      visible: source !== null
      text: source.audio.muted ? "\udb80\udf6d" : "\udb80\udf6c"
      font.family: root.fontSymbol.family
      font.pixelSize: sink.audio.muted ? 14 : 16
      color: "white"
    }
  }

  WrapperMouseArea {
    onClicked: sink.audio.muted = !sink.audio.muted
    width: font.pixelSize
    Text {
      visible: sink
      text: sink.audio.muted ? "\udb81\udd81" : "\udb81\udd7e"
      font: root.fontSymbol
      color: "white"
      anchors.verticalCenter: parent.verticalCenter
    }
  }

  WrapperMouseArea {
    width: font.pixelSize * 2
    Text {
      //visible: !sink.audio.muted
      text: Math.round(sink.audio.volume * 100).toString().padStart(3, " ") + "%"
      font: root.fontPixel
      width: root.font.pixelSize * 2
      color: "white"
      anchors.verticalCenter: parent.verticalCenter
    }
  }
}
