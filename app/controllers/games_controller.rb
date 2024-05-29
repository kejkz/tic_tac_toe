class GamesController < ApplicationController
  def new
    Rails.logger.info(current_user)
    redirect_to new_users_path unless current_user.present?
  end
end
