class CreateMaps < ActiveRecord::Migration[5.2]
  def change
    create_table :maps do |t|
      t.text :text,null: false
      t.text :image
      t.string :address,null: false
      t.float :latitude,null: false
      t.float :longitude,null: false
      t.references :school, foreign_key: { to_table: :categories }, null: false
      t.references :tournament, foreign_key: { to_table: :categories }, null: false
      t.references :user, foreign_key: true,null: false
      t.timestamps
    end
  end
end
