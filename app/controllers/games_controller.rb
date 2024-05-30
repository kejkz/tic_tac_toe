class GamesController < ApplicationController
  def new
    redirect_to new_users_path unless current_user.present?
  end

  def show
    @game = Game.find_by(id: params[:id])

    redirect_to new_game_path, 'Cannot find a provided game' if @game.blank?
    redirect_to new_game_path, 'Game is complete' if @game.state == 'complete'
    redirect_to new_game_path, 'Access forbidden' unless current_user == @game.x_user || current_user == @game.o_user

    current_user.playing!

    @game_logic = ::TicTacToeGame.new(@game)
  end

  def update
    Rails.logger.info(params)
  end
end
