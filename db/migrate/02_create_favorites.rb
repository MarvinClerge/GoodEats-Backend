class CreateFavorites < ActiveRecord::Migration[5.1]
  def change
    create_table :favorites do |t|
      t.belongs_to :user, foreign_key: true
      t.string :location_name
      t.string :place_id

      t.timestamps
    end
  end
end
