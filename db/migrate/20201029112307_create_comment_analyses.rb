class CreateCommentAnalyses < ActiveRecord::Migration[5.2]
  def change
    create_table :comment_analyses do |t|
      t.references :user, foreign_key: true,null: false
      t.references :analysis, foreign_key: true,null: false
      t.text :text,null: false
      t.timestamps
    end
  end
end
