//@ pragma UseQApplication
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
}
