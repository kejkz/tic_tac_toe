require "test_helper"

class GameTest < ActiveSupport::TestCase
  test "fresh state" do
    x_user = User.create!(name: 'josh11')
    o_user = User.create!(name: 'mickey20')
    game = Game.new(x_user: x_user, o_user: o_user)
    assert game.save, 'Game state is valid'
  end

  test "wrong state" do
    game = Game.new

    assert_not game.save, 'Missing game users'
  end
end
