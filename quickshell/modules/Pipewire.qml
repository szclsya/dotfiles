import Quickshell.Services.Pipewire
import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import Quickshell.Widgets
import qs.services

// Using a rect here bc icons are not monospace
RowLayout {
  height: root.height
  width: root.font.pixelSize * 4.5
  visible: PipewireService.ready
  clip: true

  property var source: Pipewire.defaultAudioSource
  property var sink: Pipewire.defaultAudioSink

  WrapperMouseArea {
    hoverEnabled: true
    onClicked: source.audio.muted = !source.audio.muted
    onEntered: sourceTooltip.show(source.name)
    Text {
      visible: source !== null
      text: source.audio.muted ? "\udb80\udf6d" : "\udb80\udf6c"
      font.family: root.fontSymbol.family
      font.pixelSize: sink.audio.muted ? 14 : 16
      color: "white"
    }
    ToolTip {
      id: sourceTooltip
      bottomMargin: root.height
      delay: 200
      popupType: Popup.Native
      contentItem: Text {
        text: sourceTooltip.text
        color: "white"
      }
      background: Rectangle {
        color: "green"
        radius: 5
      }
    }
  }

  WrapperMouseArea {
    hoverEnabled: true
    onClicked: sink.audio.muted = !sink.audio.muted
    onEntered: sinkTooltip.show(sink.name)
    width: font.pixelSize
    Text {
      visible: sink
      text: sink.audio.muted ? "\udb81\udd81" : "\udb81\udd7e"
      font: root.fontSymbol
      color: "white"
      anchors.verticalCenter: parent.verticalCenter
    }
    ToolTip {
      id: sinkTooltip
      bottomMargin: root.height
      delay: 200
      popupType: Popup.Native
      contentItem: Text {
        text: sinkTooltip.text
        color: "white"
      }
      background: Rectangle {
        color: "green"
        radius: 5
      }
    }
  }

  WrapperMouseArea {
    width: font.pixelSize * 2
    onWheel: wheel => {
      if (wheel.angleDelta.y > 0) {
        sink.audio.volume += 0.05
      } else {
        sink.audio.volume -= 0.05
      }
    }
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
