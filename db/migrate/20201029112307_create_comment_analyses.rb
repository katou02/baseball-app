class CreateCommentAnalyses < ActiveRecord::Migration[5.2]
  def change
    create_table :comment_analyses do |t|
      t.integer :user_id
      t.integer :analysis_id
      t.text :text
      t.timestamps
    end
  end
end
