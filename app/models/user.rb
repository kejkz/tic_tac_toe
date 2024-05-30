class User < ApplicationRecord
  enum :status, [:away, :available, :playing], default: :away
  validates :name, length: { minimum: 2, maximum: 64 }
  has_many :my_games, class_name: 'Game', foreign_key: :x_user_id, dependent: :delete_all
  has_many :others_games, class_name: 'Game', foreign_key: :o_user_id, dependent: :delete_all
end
