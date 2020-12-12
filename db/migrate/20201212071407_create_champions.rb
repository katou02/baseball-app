class CreateChampions < ActiveRecord::Migration[5.2]
  def change
    create_table :champions do |t|
      t.integer :user_id
      t.references :champion_school, foreign_key: { to_table: :categories }, null: false
      t.references :tournament, foreign_key: { to_table: :categories }, null: false
      t.timestamps
    end
  end
end
