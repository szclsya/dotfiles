import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import Quickshell.Io
import Quickshell.Widgets

import qs.Services

// TODO: quickshell don't support systemd-networkd and IWD yet, using a primitive way to do things
RowLayout {
  spacing: 8
  height: parent.height
  Repeater {
    model: Config.networks

    Row {
      spacing: 4
      Rectangle {
        color: "transparent"
        implicitWidth: netItem.width
        implicitHeight: netItem.height
        ToolTip {
          id: netTooltip
          delay: 200
          popupType: Popup.Native
          contentItem: Text {
            text: netTooltip.text
            color: "white"
          }
          background: Rectangle {
            color: "#3b3a39"
            radius: 5
          }
        }
        MouseArea {
          anchors.fill: parent
          hoverEnabled: true
          onEntered: netTooltip.show(modelData.interface)
          onExited: netTooltip.hide()
        }

        Row {
          id: netItem
          spacing: 4
          Text {
            text: {
              if (netinfo.type === "ether") {
                if (netinfo.online) {
                  "\udb83\udc9d"
                } else if (netinfo.address) {
                  "\udb83\udc9a"
                } else if (netinfo.carrier) {
                  "\udb83\udc8a"
                } else {
                  "\udb83\udc9c"
                }
              } else if (netinfo.type === "wlan") {
                if (netinfo.online) {
                  "\udb82\udd2a"
                } else if (netinfo.address) {
                  "\udb82\udd28"
                } else if (netinfo.carrier) {
                  "\udb82\udd2b"
                } else {
                  "\udb82\udd2f"
                }
              } else {
                ""
              }
            }
            color: "white"
            font: bar.fontSymbol
            anchors.verticalCenter: parent.verticalCenter
          }

          Text {
            text: {
              if (Config.redact) {
                "REDACTED"
              } else if (netinfo.ssid) {
                netinfo.ssid
              } else if (netinfo.ipv4) {
                netinfo.ipv4
              } else {
                ""
              }
            }
            color: "white"
            font: bar.fontPixel
            anchors.verticalCenter: parent.verticalCenter
          }
        }

        Connections {
          target: NetworkDEvent
          function onNetworkChanged() { netinfo.running = true }
        }
      }

      Process {
        id: netinfo
        property var type
        property bool carrier
        property bool address
        property bool online
        property var ssid
        property var ipv4
        property var ipv6

        running: true
        command: ["networkctl", "--json=short", "status", modelData.interface]
        stdout: StdioCollector {
          onStreamFinished: {
            var res = JSON.parse(this.text)
            netinfo.type = res["Type"]
            netinfo.carrier = res["CarrierState"] === "carrier"
            netinfo.address = res["AddressState"] === "routable"
            netinfo.online = res["OnlineState"] === "online"
            netinfo.ssid = res["SSID"]
            if (res["Addresses"]) {
              var ipv4s = res["Addresses"].filter((x) => x["Family"] === 2)
              if (ipv4s[0]) {
                netinfo.ipv4 = ipv4s[0]["Address"].join(".")
                netinfo.ipv4 += "/" + ipv4s[0]["PrefixLength"]
              } else {
                netinfo.ipv4 = ""
              }
              var ipv6s = res["Addresses"].filter((x) => x["Family"] == 10)
              if (ipv6s[0]) {
                netinfo.ipv6 = ipv6s[0]["Address"].join("::")
                netinfo.ipv6 += "/" + ipv6s[0]["PrefixLength"]
              } else {
                netinfo.ipv6 = ""
              }
            }
          }
        }
      }
    }
  }
}
