import Quickshell.Services.Pipewire
import QtQuick
import QtQuick.Layouts
import Quickshell.Widgets

// Using a rect here bc icons are not monospace
Rectangle {
  height: root.height
  color: "transparent"

  property var source: Pipewire.defaultAudioSource
  property var sink: Pipewire.defaultAudioSink
  width: root.font.pixelSize * 4.5
  clip: true

  WrapperMouseArea {
    anchors {
      left: parent.left
      verticalCenter: parent.verticalCenter
    }
    onClicked: source.audio.muted = !source.audio.muted
    Text {
      visible: source !== null
      text: source.audio.muted ? "\udb80\udf6d" : "\udb80\udf6c"
      font: root.fontSymbol
      color: "white"
    }
  }

  WrapperMouseArea {
    anchors {
      left: parent.left
      leftMargin: root.font.pixelSize * 1.2
      verticalCenter: parent.verticalCenter
    }
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
    anchors {
      right: parent.right
      verticalCenter: parent.verticalCenter
    }

    width: font.pixelSize * 2
    Text {
      //visible: !sink.audio.muted
      text: Math.round(sink.audio.volume * 100).toString().padStart(3, " ") + "%"
      font: root.font
      width: root.font.pixelSize * 2
      color: "white"
      anchors.verticalCenter: parent.verticalCenter
    }
  }
}
