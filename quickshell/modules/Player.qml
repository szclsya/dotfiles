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
  property var max_len: Config.modules["Player"] ? Config.modules["Player"]["max_len"] : 36

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
      onClicked: player.togglePlaying()
      Text {
        id: playButton
        anchors.verticalCenter: parent.verticalCenter
        text: player && player.isPlaying ? "\udb80\udfe4" : "\udb81\udc0a"
        font.family: root.fontSymbol.family
        font.pixelSize: player && player.isPlaying ? 16 : 17
        width: font.pixelSize / 2
        color: player ? "white" : "grey"
      }
    }
    WrapperMouseArea {
      onClicked: player.next()
      Text {
        id: nextButton
        anchors.verticalCenter: parent.verticalCenter
        text: "\udb81\udcad"
        font: root.fontSymbol
        width: font.pixelSize / 2
        color: player && player.canGoNext ? "white" : "grey"
      }
    }
    Item { width: 1 }
    WrapperMouseArea {
      onClicked: player.togglePlaying()
      Rectangle {
        implicitHeight: root.height
        implicitWidth: childrenRect.width
        color: "transparent"
        Marquee {
          anchors.verticalCenter: parent.verticalCenter
          max_len: Config.modules.Player.max_len ? Config.modules.Player.max_len : 36
          text: {
            if (!player) {
              "No Player"
            } else if (player.trackTitle == "") {
              "No Disc"
            } else {
              var res = player.trackTitle
              if (player.trackAlbum) {
                res += " - " + player.trackAlbum
              }
              res
            }
          }
          font: root.fontPixel
          color: "white"
          Component.onCompleted: {
            player.trackChanged.connect(reset)
          }
        }
      }
    }
  }
}
