import consumer from "channels/consumer"

consumer.subscriptions.create({ channel: "AvailableChannel", room: "Waiting Room"}, {
  initialized() {
    this.update = this.update.bind(this)
  },

  connected() {
    this.install()
    this.update()
  },

  disconnected() {
    this.uninstall()
  },

  received(data) {
    this.uninstall()
  },

  rejected() {
    this.uninstall()
  },

  update() {
    this.documentIsActive ? this.available() : this.away()
  },

  away() {
    this.perform("away")
  },

  available() {
    this.perform("available", { available_for: 'game' })
  },

  playing() {
    this.perform('playing', { game: 'game' })
  },

  install() {
    document.addEventListener("turbo:load", this.update)
    document.addEventListener("visibilitychange", this.update)
  },

  get documentIsActive() {
    return document.visibilityState === "visible" && document.hasFocus();
  },

  uninstall() {
    document.removeEventListener("turbo:load", this.update)
    document.removeEventListener("visibilitychange", this.update)
  },
});
