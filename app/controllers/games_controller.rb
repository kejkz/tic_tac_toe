class GamesController < ApplicationController
  def new
    redirect_to new_users_path unless current_user.present?
  end
end
