import QtQuick
import QtQuick.Layouts
import qs.Services

RowLayout {
  visible: BacklightService.enabled
  height: bar.height
  readonly property int brightness: Math.round(BacklightService.brightness * 100)
  spacing: 4
  Text {
    text: {
      switch (true) {
      case (brightness <= 10):
        "\udb86\ude4e"; break
      case (brightness <= 20):
        "\udb86\ude4f"; break
      case (brightness <= 30):
        "\udb86\ude50"; break
      case (brightness <= 40):
        "\udb86\ude51"; break
      case (brightness <= 50):
        "\udb86\ude52"; break
      case (brightness <= 60):
        "\udb86\ude53"; break
      case (brightness <= 70):
        "\udb86\ude54"; break
      case (brightness <= 80):
        "\udb86\ude55"; break
      case (brightness <= 90):
        "\udb86\ude56"; break
      default:
        "\udb81\udee8"
      }
    }
    color: "white"
    font.family: bar.fontSymbol.family
    font.pixelSize: 14
    width: 10
    bottomPadding: 2
  }
  Text {
    text: (brightness + "%").padStart(4, " ")
    color: "white"
    font: bar.fontPixel
  }
}
