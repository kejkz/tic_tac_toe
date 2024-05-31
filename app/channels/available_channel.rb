class AvailableChannel < ApplicationCable::Channel
  def subscribed
    current_user.available!
    stream_for current_user
  end

  def unsubscribed
    current_user.away!
  end

  def available
    current_user.available!
  end

  def away
    current_user.away!
  end

  def playing
    current_user.playing!
  end

  periodically every: 2.seconds do
    @available_users = User.available
    Rails.logger.debug("Available users: #{@available_users.pluck(:id, :name)}")
    @game = Game.available_for(current_user).first

    if @available_users.count >= 2 || @game.present?
      Rails.logger.debug('Enough users active for a game')

      if @game.present?
        Rails.logger.debug("Found a game for this user... initialize game #{@game.id}")

        unless @game.in_progress? || @game.ready?
          Rails.logger.debug("Game is active: #{@game.id}")
          another_available_user = @available_users.where.not(id: current_user.id).first

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
end
