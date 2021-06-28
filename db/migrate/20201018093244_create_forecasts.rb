class CreateForecasts < ActiveRecord::Migration[5.2]
  def change
    create_table :forecasts do |t|
      t.text :text,null: false
      t.string :round,null: false
      t.integer :probability,null: false
      t.references :user, foreign_key: true,null: false
      t.references :win_school, foreign_key: { to_table: :categories }, null: false
      t.references :lose_school, foreign_key: { to_table: :categories }, null: false
      t.references :tournament, foreign_key: { to_table: :categories }, null: false
      t.timestamps
    end
  end
end
