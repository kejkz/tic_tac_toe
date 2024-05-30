# frozen_string_literal: true

class TicTacToe
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

  def move(index, character = "X")
    character = board[index]
    board
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
      end
    end
  else
    false
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

  # Draw when board is full and cannot define the win combo
  def draw?(board)
    if full?(board) == true && won?(board) == false
      true
    else
      false
    end
  end

  # Over happens when X or O won, or every position is occupied, or draw, or X or Y won but not all the positions are occupied
  def over?(board)
    if won?(board) || full?(board) || draw?(board)
      true
    else
      nil
    end
  end

  # Check who is the winner, X or O
  def winner(board)
    checkwinner = []
    checkwinner = won?(board)

    if won?(board) == false
      nil
    else
      if board[checkwinner[0]] == "X"
        return "X"
      else
        return "O"
      end
  end

  private

  def prepare_game
    @game.current_state = ['', '', '', '', '', '', '', '', '']
  end

  def board
    @game.current_state
  end
end
