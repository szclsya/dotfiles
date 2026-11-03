//@ pragma UseQApplication
//@ pragma Env QT_QUICK_BACKEND = software
//@ pragma NativeTextRendering
import Quickshell
import QtQuick
import "./Services/"
import "./Bar/"

Scope {
  id: root

  Variants {
    model: Quickshell.screens
    delegate: Bar {}
  }

  Variants {
    model: Quickshell.screens
    delegate: Notification {}
  }
}
