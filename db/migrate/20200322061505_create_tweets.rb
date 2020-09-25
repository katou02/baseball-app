class CreateTweets < ActiveRecord::Migration[5.2]
  def change
    create_table :tweets do |t|
      t.string :title_info
      t.text   :text
      t.text   :image
      t.integer :school_a_score
      t.integer :school_b_score
      t.integer :tournament_id
      t.timestamps null: true
      t.references :school_a, foreign_key: { to_table: :categories }, null: false
      t.references :school_b, foreign_key: { to_table: :categories }, null: false
    end
  end
end
