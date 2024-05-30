require "test_helper"

class UserTest < ActiveSupport::TestCase
  test "user status" do
    user = User.create(name: 'Hacker')
    assert user.status == 'away'

    user.available!
    assert user.status == 'available'

    user.playing!
    assert user.status == 'playing'
  end
end
