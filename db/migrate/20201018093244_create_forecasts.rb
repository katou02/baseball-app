class CreateForecasts < ActiveRecord::Migration[5.2]
  def change
    create_table :forecasts do |t|
      t.text :text
      t.string :round
      t.integer :probability
      t.integer :user_id
      t.references :win_school, foreign_key: { to_table: :categories }, null: false
      t.references :lose_school, foreign_key: { to_table: :categories }, null: false
      t.references :tournament, foreign_key: { to_table: :categories }, null: false
      t.timestamps
    end
  end
end
