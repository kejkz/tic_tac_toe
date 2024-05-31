import { Controller } from "@hotwired/stimulus"
import consumer from "../channels/consumer"

export default class extends Controller {
  connect() {
    console.log('Connected')
    this.channel = consumer.subscriptions.create({ channel: "GameChannel", room: "Game"}, {
      connected: this.connected.bind(this),
      disconnected: this.disconnected.bind(this),
      received: this.received.bind(this),
      rejected: this.rejected.bind(this)
    })
  }

  connected() {
    console.log("GAME CHANNEL RUNNING")
  }

  disconnected() {
    console.log("disconnected from the server")
  }

  received(gameData) {
    console.log(gameData)
  }

  rejected() {
    console.log("Game rejected")
  }
}
