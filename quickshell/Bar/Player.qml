import QtQuick
import QtQuick.Layouts
import Quickshell.Services.Mpris
import Quickshell.Widgets
import qs.Services

Rectangle {
  width: childrenRect.width
  height: bar.height
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
        font.family: bar.fontSymbol.family
        font.pixelSize: bar.fontSymbol.pixelSize + 1
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
        font.family: bar.fontSymbol.family
        font.pixelSize: player && player.isPlaying ? 17 : 18
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
        font.family: bar.fontSymbol.family
        font.pixelSize: bar.fontSymbol.pixelSize + 1
        width: font.pixelSize / 2
        color: player && player.canGoNext ? "white" : "grey"
      }
    }
    Item { width: 1 }
    WrapperMouseArea {
      onClicked: player.togglePlaying()
      Rectangle {
        implicitHeight: bar.height
        implicitWidth: childrenRect.width
        color: "transparent"
        Marquee {
          anchors.verticalCenter: parent.verticalCenter
          max_len: bar.width / font.pixelSize * 2 * 0.12
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
          font: bar.fontPixel
          color: "white"
          Component.onCompleted: {
            player.trackChanged.connect(reset)
          }
        }
      }
    }
  }
}
