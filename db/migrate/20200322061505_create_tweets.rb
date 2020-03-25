class CreateTweets < ActiveRecord::Migration[5.2]
  def change
    create_table :tweets do |t|
      t.string :name
      t.string :title
      t.string :title_info
      t.string :school_a
      t.string :school_b
      t.text   :text
      t.text   :image
      t.timestamps null: true
    end
  end
end
