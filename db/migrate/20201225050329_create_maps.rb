class CreateMaps < ActiveRecord::Migration[5.2]
  def change
    create_table :maps do |t|
      t.references :school, foreign_key: { to_table: :categories }, null: false
      t.text :text
      t.string :address
      t.float :latitude
      t.float :longitude
      t.timestamps
    end
  end
end
