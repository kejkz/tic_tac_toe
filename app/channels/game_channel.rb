class GameChannel < ApplicationCable::Channel
  def subscribed
    @game = Game.available_for(current_user).first
    stream_for @game
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def start
    @game.in_progress!
  end

  # periodically every: 5.seconds do
  #   transmit(@game) if @game.present?
  # end
end
