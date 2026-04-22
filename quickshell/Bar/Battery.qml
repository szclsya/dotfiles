import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import Quickshell.Services.UPower
import Quickshell.Widgets

RowLayout {
  spacing: 8
  height: parent.height
  Repeater {
    model: UPower.devices.values.filter(d => d.isLaptopBattery)
    WrapperMouseArea {
      readonly property int percentage: Math.round(modelData.percentage * 100)
      hoverEnabled: true
      function toHrMinStr(i) {
        return Math.min(99, Math.floor(i / 3600)).toString().padStart(2, "0") + ":" + Math.floor(i % 3600 / 60).toString().padStart(2, "0")
      }
      property string tooltipText: {
        if (modelData.state === UPowerDeviceState.Discharging) {
          "Discharging, " + toHrMinStr(modelData.timeToEmpty) + " remaining"
        } else if (modelData.state === UPowerDeviceState.Charging) {
          "Charging, " + toHrMinStr(modelData.timeToFull) + " remaining"
        } else {
          "Not charging"
        }
      }
      onEntered: batteryTooltip.show(tooltipText)
      onExited: batteryTooltip.hide()
      ToolTip {
        id: batteryTooltip
        delay: 200
        popupType: Popup.Native
        contentItem: Text {
          text: batteryTooltip.text
          color: "white"
        }
        background: Rectangle {
          color: "#3b3a39"
          radius: 5
        }
      }
      Row {
        Text {
          text: {
            if (modelData.state === UPowerDeviceState.PendingCharge) {
              if (percentage > 95) { // Fully charged
                "\udb85\udfe2"
              } else { // Battery care
                "\udb84\ude0f"
              }
            } else if (modelData.state === UPowerDeviceState.Charging) {
              switch (true) {
              case (percentage <= 10):
                "\udb82\udc9c"; break
              case (percentage <= 20):
                "\udb80\udc86"; break
              case (percentage <= 30):
                "\udb80\udc87"; break
              case (percentage <= 40):
                "\udb80\udc88"; break
              case (percentage <= 50):
                "\udb82\udc9d"; break
              case (percentage <= 60):
                "\udb80\udc89"; break
              case (percentage <= 70):
                "\udb82\udc9e"; break
              case (percentage <= 80):
                "\udb80\udc8a"; break
              case (percentage <= 90):
                "\udb80\udc8b"; break
              default:
                "\udb80\udc85"
              }
            } else {
              switch (true) {
              case (percentage <= 10):
                "\udb80\udc7a"; break
              case (percentage <= 20):
                "\udb80\udc7b"; break
              case (percentage <= 30):
                "\udb80\udc7c"; break
              case (percentage <= 40):
                "\udb80\udc7d"; break
              case (percentage <= 50):
                "\udb80\udc7e"; break
              case (percentage <= 60):
                "\udb80\udc7f"; break
              case (percentage <= 70):
                "\udb80\udc80"; break
              case (percentage <= 80):
                "\udb80\udc81"; break
              case (percentage <= 90):
                "\udb80\udc82"; break
              default:
                "\udb80\udc79"
              }
            }
          }
          color: "white"
          font.family: bar.fontSymbol.family
          font.pixelSize: 14
          width: 10
          topPadding: 1
        }
        Text {
          text: percentage.toString().padStart(3, " ") + "%"
          color: "white"
          font: bar.fontPixel
          width: bar.fontPixel.pixelSize * 2
        }
        Text {
          visible: modelData.state === UPowerDeviceState.Discharging
          text: " " + toHrMinStr(modelData.timeToEmpty)
          color: "white"
          font: bar.fontPixel
          width: bar.fontPixel.pixelSize * 3
        }
      }
    }
  }
}
