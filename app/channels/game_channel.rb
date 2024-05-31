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

  periodically every: 5.seconds do
    if @game.present?
      unless @game.in_progress? || @game.ready?
        another_available_user = User.where(status: 'available').where.not(id: current_user.id).first

        if another_available_user.present?
          @game.o_user = another_available_user
          @game.state = 'ready'
          @game.save!
        end
      end
      transmit(@game)
    end
  end
end
