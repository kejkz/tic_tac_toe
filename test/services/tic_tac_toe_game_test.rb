require "test_helper"

class TicTacToeTest < ActiveSupport::TestCase
  def test_game_workflow
    x_user = User.create!(name: 'josh11')
    o_user = User.create!(name: 'mickey20')
    game = Game.new(x_user: x_user, o_user: o_user)
    game_logic = TicTacToeGame.new(game)

    assert game.current_state == ['', '', '', '', '', '', '', '', '']

    game_logic.move(4, x_user)

    assert game.current_state == ['', '', '', '', 'X', '', '', '', '']

    game.save!

    assert game.reload.current_state == ['', '', '', '', 'X', '', '', '', '']
  end

  def test_win_combos
    x_user = User.create!(name: 'josh11')
    o_user = User.create!(name: 'mickey20')
    game = Game.new(x_user: x_user, o_user: o_user)
    game_logic = TicTacToeGame.new(game)

    game.current_state = ['X', 'X', 'X', 'O', 'O']

    assert game_logic.won? == [0,1,2]
    assert game_logic.winner == 'X'

    game.current_state = ['X', 'O', 'X', 'O', 'X', 'O', 'X', '', '']
    assert game_logic.won? == [2, 4, 6]

    assert game_logic.winner == 'X'

    game.current_state = ['', 'O', 'O', 'X', 'X', 'O', 'X', 'X', 'O']

    assert game_logic.winner == 'O'
  end

  def test_current_player
    x_user = User.create!(name: 'josh11')
    o_user = User.create!(name: 'mickey20')
    game = Game.new(x_user: x_user, o_user: o_user)
    game_logic = TicTacToeGame.new(game)

    game.current_state = ['X', '', '', '', '', '', '', '']

    assert game_logic.current_player == o_user
  end
end
