import { Controller } from "@hotwired/stimulus"
import consumer from "../channels/consumer"

export default class extends Controller {
  static targets = ['game']

  connect() {
    console.log('Connected')
    console.log(this.gameTarget)
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

    this.gameTarget.src = `/games/${gameData.game.id}`

    console.log(this.gameTarget)
  }

  rejected() {
    console.log("Game rejected")
  }
}
