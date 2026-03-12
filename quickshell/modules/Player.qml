import QtQuick
import QtQuick.Layouts
import Quickshell.Services.Mpris

Rectangle {
  visible: Mpris.players.values[0].isPlaying || Mpris.players.values[0].canPlay
  width: row.width
  height: root.height
  color: "transparent"

  RowLayout {
    id: row
    spacing: 8
    height: parent.height

    Text {
      visible: Mpris.players.values[0].canGoPrevious
      text: "\udb81\udcad"
      font: root.font
      color: "white"
    }
    Text {
      text: "\udb81\udcad"
      font: root.font
      color: "white"
    }
    Text {
      visible: Mpris.players.values[0].canGoNext
      text: "\udb81\udcad"
      font: root.font
      color: "white"
    }
    Text {
      text: Mpris.players.values[0].trackTitle
      font: root.font
      color: "white"
    }
  }
}
