class CreateTweets < ActiveRecord::Migration[5.2]
  def change
    create_table :tweets do |t|
      t.string :title, null: false
      t.string :round, null: false
      t.text   :text, null: false
      t.text   :image
      t.integer :school_a_score, null: false
      t.integer :school_b_score, null: false
      t.timestamps null: true
      t.references :school_a, foreign_key: { to_table: :categories }, null: false
      t.references :school_b, foreign_key: { to_table: :categories }, null: false
      t.references :tournament, foreign_key: { to_table: :categories }, null: false
    end
  end
end
