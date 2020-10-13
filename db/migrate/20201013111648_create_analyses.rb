class CreateAnalyses < ActiveRecord::Migration[5.2]
  def change
    create_table :analyses do |t|
      t.text :text
      t.string :attack
      t.string :defensive
      t.string :pitcher
      t.string :comprehensive
      t.references :school, foreign_key: { to_table: :categories }, null: false
      t.references :tournament, foreign_key: { to_table: :categories }, null: false
      t.timestamps
    end
  end
end
