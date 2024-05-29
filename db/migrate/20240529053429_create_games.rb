class CreateGames < ActiveRecord::Migration[7.1]
  def change
    enable_extension 'pgcrypto'

    create_table :games, id: :uuid do |t|
      t.integer :state, default: 0
      t.belongs_to :x_user, foreign_key: {to_table: :users}
      t.belongs_to :o_user, foreign_key: {to_table: :users }

      t.string :current_state, array: true, default: []
      t.timestamps
    end
  end
end
