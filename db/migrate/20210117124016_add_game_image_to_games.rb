class AddGameImageToGames < ActiveRecord::Migration[5.2]
  def change
    add_column :games, :game_image, :string
  end
end
