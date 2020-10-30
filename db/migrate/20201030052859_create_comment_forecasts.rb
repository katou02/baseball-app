class CreateCommentForecasts < ActiveRecord::Migration[5.2]
  def change
    create_table :comment_forecasts do |t|

      t.timestamps
    end
  end
end
