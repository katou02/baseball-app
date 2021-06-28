class CreateCommentForecasts < ActiveRecord::Migration[5.2]
  def change
    create_table :comment_forecasts do |t|
      t.references :user, foreign_key: true,null: false
      t.references :forecast, foreign_key: true,null: false
      t.text :text,null: false
      t.timestamps
    end
  end
end
