class CreateAnalyses < ActiveRecord::Migration[5.2]
  def change
    create_table :analyses do |t|
      t.text :text
      t.integer :attack
      t.integer :defensive
      t.integer :pitcher
      t.integer :comprehensive
      t.integer :expectations
      t.integer :user_id
      t.references :school, foreign_key: { to_table: :categories }, null: false
      t.references :tournament, foreign_key: { to_table: :categories }, null: false
      t.timestamps
    end
  end
end
