pragma Singleton
import QtQuick
import Quickshell
import Quickshell.Wayland

Singleton {
  property list<var> screenshots
  Instantiator {
    id: screenviews
    model: Quickshell.screens
    PanelWindow {
      id: window
      color: "transparent"
      aboveWindows: false
      visible: false
      ScreencopyView {
        captureSource: modelData
        onSourceSizeChanged: {
          console.log(sourceSize)
        }
        onHasContentChanged: indeed => {
          // Put the image in list
          console.log("has content")
          this.implicitHeight = this.sourceSize.height
          this.implicitWidth = this.sourceSize.width
          console.log("implicitHeight: " + this.implicitWidth)
          this.grabToImage(img => {
            console.log("frame captured")
            screenshots.push({ screen: screen, screenshot: img })
            // Cleanup
          })
        }
      }
    }
  }
  function takeAll() {
    console.log("Number of preshot slots: " + screenviews.count)
    for (var i=0; i<screenviews.count; i++) {
      let screenview = screenviews.objectAt(i)
      console.log("taking screenshot of " + screenview)
      screenview.captureFrame()
    }
  }
}
