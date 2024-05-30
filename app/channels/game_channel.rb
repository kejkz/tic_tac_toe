class GameChannel < ApplicationCable::Channel
  def subscribed
    @game = Game.find_or_create_by(x_user: current_user)
    stream_for @game
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def start
    @game.in_progress!
  end

  periodically every: 5.seconds do
    unless @game.in_progress? || @game.ready?
      another_available_user = User.where(status: 'available').where.not(id: current_user.id).first

      if another_available_user.present?
        @game.o_user = another_available_user
        @game.state = 'ready'
        @game.save!


        # AvailableChannel.broadcast(current_user, { game_id: @game.id })
        # AvailableChannel.broadcast_to(another_available_user, @game)
      end

      transmit(@game)
    end
  end
end
