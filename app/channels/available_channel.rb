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
end
