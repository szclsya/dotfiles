import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import Quickshell
import Quickshell.Widgets
import Quickshell.Services.SystemTray

RowLayout {
  anchors.verticalCenter: parent.verticalCenter
  //Text { text: "bruh" }
  Item { width: 2 }
  Repeater {
    model: SystemTray.items

    IconImage {
      id: icon
      required property SystemTrayItem modelData

      source: modelData.icon
      implicitSize: bar.height * 0.67
      smooth: true

      ToolTip {
        id: tooltip
        bottomMargin: bar.height
        delay: 200
        popupType: Popup.Native
        contentItem: Text {
          text: tooltip.text
          color: "white"
        }
        background: Rectangle {
          color: "#3b3a39"
          radius: 5
        }
      }
      QsMenuAnchor {
        id: menu
        anchor {
          item: icon
          gravity: Edges.Bottom | Edges.Left
        }
        menu: modelData.menu
      }
      MouseArea {
        anchors.fill: parent
        acceptedButtons: Qt.LeftButton | Qt.RightButton
        hoverEnabled: true
        onClicked: mouse => {
          if (mouse.button === Qt.LeftButton) {
            modelData.activate()
          } else {
            menu.open()
          }
        }
        onEntered: {
          if (icon.modelData.tooltipTitle === "")
            return

          tooltip.show(icon.modelData.tooltipTitle)
        }
        onExited: tooltip.hide()
      }
    }
  }
}
