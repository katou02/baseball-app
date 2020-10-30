class CreateCommentForecasts < ActiveRecord::Migration[5.2]
  def change
    create_table :comment_forecasts do |t|
      t.integer :user_id
      t.integer :forecast_id
      t.text :text
      t.timestamps
    end
  end
end
