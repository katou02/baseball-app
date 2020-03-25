class CreateSchools < ActiveRecord::Migration[5.2]
  def change
    create_table :schools do |t|
      t.string :school_a
      t.string :school_b
      t.integer :school_a_score
      t.integer :school_b_score

      t.timestamps
    end
  end
end
