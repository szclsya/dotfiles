import Quickshell
import Quickshell.Services.Pipewire

Singleton {
  id: pipewire

  PwObjectTracker {
    objects: [Pipewire.defaultAudioSink, Pipewire.defaultAudioSource]
  }
}
