class CreateMaps < ActiveRecord::Migration[5.2]
  def change
    create_table :maps do |t|
      t.text :text
      t.text :image
      t.string :address
      t.float :latitude
      t.float :longitude
      t.references :school, foreign_key: { to_table: :categories }, null: false
      t.references :tournament, foreign_key: { to_table: :categories }, null: false
      t.integer :user_id
      t.timestamps
    end
  end
end
