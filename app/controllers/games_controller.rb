class GamesController < ApplicationController
  def new
    redirect_to new_users_path unless current_user.present?

    @game = Game.find_or_create_by(x_user: current_user, state: :fresh)

    Rails.logger.debug(@game)
  end

  def show
    redirect_to new_game_path, notice: 'Cannot find a provided game' unless game.present?
    redirect_to new_game_path, notice: 'Access forbidden' unless current_user == game.x_user || current_user == game.o_user

    current_user.playing!

    @game_logic = ::TicTacToeGame.new(game)
    game.save!

    if game.complete?
      flash.now[:notice] = "The winner is #{@game_logic.winner.name}" if @game_logic.won?
      flash.now[:notice] = "Draw game" if @game_logic.draw?
    end
  end

  def update
    @game_logic = ::TicTacToeGame.new(game)

    render :show, status: :unprocessable_entity, notice: 'Cannot play' and return unless @game_logic.current_player == current_user
    render :show, status: :unprocessable_entity, notice: 'This game is complete' and return if @game.complete?

    another_user = game.x_user == current_user ? game.o_user : game.x_user

    if @game_logic.turn(current_user, update_params[:position].to_i)
      game.save!
      if @game_logic.over?
        flash.now[:message] = "Game won by #{@game_logic.winner.name}" if @game_logic.won?
        flash.now[:message] = "Draw Game!" if @game_logic.draw?
        game.complete!
      end
      GameChannel.broadcast_to(game, notice: 'Move made', game: game)
    else
      flash.now[:error] = 'There was a problem making a move'
    end

    redirect_to game_path(game)
  end

  private

    def game
      @game ||= Game.find_by(id: params[:id])
    end

    def update_params
      params.permit(:id, :position)
    end
end
