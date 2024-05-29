class CreateGames < ActiveRecord::Migration[7.1]
  def change
    enable_extension 'pgcrypto'

    create_table :games, id: :uuid do |t|
      t.timestamps
    end
  end
end
