class Game < ApplicationRecord
  enum state: [:fresh, :ready, :in_progress, :complete]

  belongs_to :x_user, class_name: 'User'
  belongs_to :o_user, class_name: 'User', required: false
end
