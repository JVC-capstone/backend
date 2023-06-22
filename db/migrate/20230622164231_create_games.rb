class CreateGames < ActiveRecord::Migration[7.0]
  def change
    create_table :games do |t|
      t.string :title
      t.text :image
      t.string :platform
      t.string :genre
      t.text :notes

      t.timestamps
    end
  end
end
