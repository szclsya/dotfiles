import QtQuick
import QtQuick.Layouts
import Quickshell.Services.Mpris
import Quickshell.Widgets
import qs.services

Rectangle {
  width: childrenRect.width
  height: root.height
  color: "transparent"

  property var player_blacklist: ["firefox", "playerctl"]
  property var player: Mpris.players.values[0]

  RowLayout {
    id: row
    height: parent.height

    WrapperMouseArea {
      onClicked: player.previous()
      Text {
        id: prevButton
        anchors.verticalCenter: parent.verticalCenter
        text: "\udb81\udcae"
        font: root.fontSymbol
        width: font.pixelSize / 2
        color: player && player.canGoPrevious ? "white" : "grey"
      }
    }
    WrapperMouseArea {
      Text {
        id: playButton
        anchors.verticalCenter: parent.verticalCenter
        text: player && player.isPlaying ? "\udb80\udfe4" : "\udb81\udc0a"
        //text: player && player.isPlaying ? "\udb81\udc0a" : "\udb80\udfe4"
        font: root.fontSymbol
        width: font.pixelSize / 2
        color: player ? "white" : "grey"
      }
    }
    WrapperMouseArea {
      Text {
        id: nextButton
        anchors.verticalCenter: parent.verticalCenter
        text: "\udb81\udcad"
        font: root.fontSymbol
        width: font.pixelSize / 2
        color: player && player.canGoNext ? "white" : "grey"
      }
    }
    Marquee {
      max_len: 26
      text: player ? player.trackTitle + " - " + player.trackAlbum : "No Disc"
      font: root.fontPixel
      color: "white"
      Component.onCompleted: {
        player.trackChanged.connect(reset)
      }
    }
  }
}
