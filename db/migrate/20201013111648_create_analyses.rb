class CreateAnalyses < ActiveRecord::Migration[5.2]
  def change
    create_table :analyses do |t|
      t.text :title, null: false
      t.text :text, null: false
      t.text   :image
      t.integer :attack, null: false
      t.integer :defensive, null: false
      t.integer :pitcher, null: false
      t.integer :comprehensive, null: false
      t.integer :expectations, null: false
      t.references :user, foreign_key: true,null: false
      t.references :school, foreign_key: { to_table: :categories }, null: false
      t.references :tournament, foreign_key: { to_table: :categories }, null: false
      t.timestamps
    end
  end
end
