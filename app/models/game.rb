class Game < ApplicationRecord
  enum state: [:fresh, :ready, :in_progress, :complete]

  belongs_to :x_user, class_name: 'User'
  belongs_to :o_user, class_name: 'User', required: false

  scope :available_for, ->(user) {
    where(x_user: user, state: [:fresh, :ready, :in_progress])
      .or(where(o_user: user, state: [:fresh, :ready, :in_progress]))
      .order(state: :desc)
      .limit(1)
  }
end
