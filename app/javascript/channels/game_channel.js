import consumer from "channels/consumer"

consumer.subscriptions.create("GameChannel", {
  connected() {
    console.log("GAME CHANNEL RUNNING")
  },

  disconnected() {
    // Called when the subscription has been terminated by the server
  },

  received(gameData) {
    if (gameData.state === 'ready') {
      window.location.href = `/games/${gameData.id}`

      this.perform('start')
    }
  }
});
