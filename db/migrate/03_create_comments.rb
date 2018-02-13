class CreateComments < ActiveRecord::Migration[5.1]
  def change
    create_table :comments do |t|
      t.belongs_to :user, foreign_key: true
      t.string :content
      t.string :place_id

      t.timestamps
    end
  end
end
