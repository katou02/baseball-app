class AddReferencesTotweets < ActiveRecord::Migration[5.2]
  def change
      add_reference :tweets, :school_a, foreign_key: { to_table: :categories }, null: false
      add_reference :tweets, :school_b, foreign_key: { to_table: :categories }, null: false
      add_reference :tweets, :tournament, foreign_key: { to_table: :categories }, null: false
  end
end
