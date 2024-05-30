# frozen_string_literal: true

class TicTacToeGame
  class NotAllowedToPlayError < StandardError; end

  WIN_COMBINATIONS = [
    [0,1,2],
    [3,4,5],
    [6,7,8],
    [0,3,6],
    [1,4,7],
    [2,5,8],
    [0,4,8],
    [2,4,6]
  ]

  def initialize(game)
    @game = game
    prepare_game
  end

  def turn(user, index)
    if valid_move?(index)
      move(index)
      @game.save!
    else
      false
    end
  end

  def move(index, user)
    char = char_for(user)
    board[index] = char
  end

  def turn_count
    counter = 0

    for i in board
      if i == "X" || i == "O"
        counter += 1
      end
    end

    counter
  end

  def char_for(user)
    if @game.x_user == user
      'X'
    elsif @game.o_user == user
      'O'
    else
      raise NotAllowedToPlayError, "Not possible to play #{@game.id} with user #{user.id}"
    end
  end

  def current_player
    current_turn_count = turn_count

    if current_turn_count % 2 == 0
      @game.x_user
    else
      @game.y_user
    end
  end

  def won?
    WIN_COMBINATIONS.each do |win_combo|
      index_0 = win_combo[0]
      index_1 = win_combo[1]
      index_2 = win_combo[2]
      position_1 = board[index_0]
      position_2 = board[index_1]
      position_3 = board[index_2]

      if position_1 == "X" && position_2 == "X" && position_3 == "X" || position_1 == "O" && position_2 == "O" && position_3 == "O"
        return win_combo
      else
        next
      end
    end

    return false
  end


  def valid_move?(index)
    def position_taken?(array, ind)
      if array[ind] == "" || array[ind] == " " || array[ind] == nil
        false
      else
        true
      end
    end

    def on_board?(number)
      if number.between?(0,8) == true
        true
      else
        false
      end
    end

    if position_taken?(@game.current_state, index) == false && on_board?(index) == true
      true
    else
      false
    end
  end

  def full?
    board.all? do |board_full|
      board_full == "X" || board_full == "O"
    end
  end

  def draw?
    if full?(board) == true && won?(board) == false
      true
    else
      false
    end
  end

  def over?
    if won? || full? || draw?
      true
    else
      nil
    end
  end

  def winner
    checkwinner = []
    checkwinner = won?

    if won? == false
      nil
    else
      if board[checkwinner[0]] == "X"
        return "X"
      else
        return "O"
      end
    end
  end

  private

  def prepare_game
    if @game.current_state.blank?
      @game.current_state = ['', '', '', '', '', '', '', '', '']
    end
  end

  def board
    @game.current_state
  end
end
