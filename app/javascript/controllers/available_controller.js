import { Controller } from "@hotwired/stimulus"
import consumer from "../channels/consumer"

export default class extends Controller {
  connect() {
    console.log('Connected')

    this.channel = consumer.subscriptions.create({ channel: "AvailableChannel", room: "Waiting Room"}, {
      initialized: this.initialized.bind(this),
      connected: this.connected.bind(this),
      disconnected: this.disconnected.bind(this),
      received: this.received.bind(this),
      rejected: this.rejected.bind(this)
    })
  }

  initialized() {
    this.update = this.update.bind(this)
  }

  connected() {
    this.install()
    this.update()
  }

  disconnected() {
    this.uninstall()
  }

  received(data) {
    console.log(data);
    if (data.state === 'ready' || data.state === 'in_progress') {
      window.location.href = `/games/${data.id}`
    }
  }

  rejected() {
    this.uninstall()
  }

  update() {
    this.documentIsActive ? this.available() : this.away()
  }

  away() {
    this.perform("away")
  }

  available() {
    this.perform("available", { available_for: 'game' })
  }

  playing() {
    this.perform('playing', { game: 'game' })
  }

  install() {
    window.addEventListener("focus", this.update)
    window.addEventListener("blur", this.update)
    document.addEventListener("turbo:load", this.update)
    document.addEventListener("visibilitychange", this.update)
  }

  get documentIsActive() {
    return document.visibilityState === "visible" && document.hasFocus();
  }

  uninstall() {
    window.removeEventListener("focus", this.update)
    window.removeEventListener("blur", this.update)
    document.removeEventListener("turbo:load", this.update)
    document.removeEventListener("visibilitychange", this.update)
  }
}
