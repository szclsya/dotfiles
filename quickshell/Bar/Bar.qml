import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Wayland
import Quickshell.Widgets

PanelWindow {
  id: bar
  required property var modelData
  screen: modelData
  WlrLayershell.namespace: "qs-bar-" + (screen?.name || "unknown")
  implicitHeight: 24
  property font font: Qt.font({
    family: "monospace",
    pixelSize: 15,
    color: "white",
  })
  property font fontPixel: Qt.font({
    family: "Ark Pixel 12px Mono zh_cn",
    pixelSize: 16,
    color: "white"
  })
  property font fontSymbol: Qt.font({
    family: "Symbols Nerd Font",
    pixelSize: 16,
    color: "white"
  })

  color: "transparent"
  anchors {
    right: true
    bottom: true
    left: true
  }

  Rectangle {
    anchors.fill: parent
    color: "transparent"

    // Left
    WrapperRectangle {
      radius: 50
      color: "#661b1a19"

      Row {
        height: 100
        spacing: 8
        WrapperRectangle {
          color: "#991b1a19"
          radius: 50
          height: bar.height
          Workspace {}
        }
        WrapperRectangle {
          color: "transparent"
          height: bar.height
          ActiveWindow {}
        }
      }
    }
    // Right
    WrapperRectangle {
      radius: 50
      color: "transparent"
      anchors.right: parent.right

      Row {
        id: right
        height: parent.height
        spacing: 2
        WrapperRectangle {
          color: "#881b1a19"
          radius: 50
          height: parent.height
          Row {
            leftPadding: 10
            rightPadding: 10
            Player {}
          }
        }
        WrapperRectangle {
          color: "#7c1d21"
          radius: 50
          height: parent.height
          Row {
            leftPadding: 10
            rightPadding: 10
            Pipewire {}
          }
        }
        WrapperRectangle {
          color: "#004e8c"
          radius: 50
          height: parent.height
          Row {
            leftPadding: 10
            rightPadding: 10
	        spacing: 8
            Bluetooth {}
            Network {}
          }
        }
        WrapperRectangle {
          color: "#986f0b"
          radius: 50
          height: parent.height
          Row {
            leftPadding: 10
            rightPadding: 10
	        spacing: 8
            Caffeine {}
            LazyLoader {
              loading: BacklightService.enabled
	          Backlight {}
            }
	        Battery {}
          }
        }
        WrapperRectangle {
          color: "#661b1a19"
          radius: 50
          Row {
            spacing: 6
            SystemTray {}
            Rectangle {
              height: bar.height
              implicitWidth: childrenRect.width
              color: "#881b1a19"
              radius: 50
              Clock {}
            }
          }
        }
      }
    }
  }
}
