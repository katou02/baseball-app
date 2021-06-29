class CreateNotifications < ActiveRecord::Migration[5.2]
  def change
    create_table :notifications do |t|
      # t.integer :visiter_id
      t.references :visiter, foreign_key: {to_table: :users}, null: false
      t.references :visited, foreign_key: {to_table: :users}, null: false
      t.references :tweet, foreign_key: {to_table: :tweets}
      t.references :analysis, foreign_key: {to_table: :analyses}
      t.references :forecast, foreign_key: {to_table: :forecasts}
      t.integer :room
      t.references :message,foreign_key: {to_table: :messages}
      t.references :comment,foreign_key: {to_table: :comments}
      t.references :comment_analysis,foreign_key: {to_table: :comment_analyses}
      t.references :comment_forecast,foreign_key: {to_table: :comment_forecasts}
      t.string :action
      t.boolean :checked, default: false, null: false

      t.timestamps
    end
  end
end
