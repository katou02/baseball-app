class CreateTweets < ActiveRecord::Migration[5.2]
  def change
    create_table :tweets do |t|
      t.string :title_info
      t.string :school_a
      t.string :school_b
      t.text   :text
      t.text   :image
      t.integer :school_a_score
      t.integer :school_b_score
      t.timestamps null: true
    end
  end
end
