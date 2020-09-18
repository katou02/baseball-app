class CreateTournamentSchools < ActiveRecord::Migration[5.2]
  def change
    create_table :tournament_schools do |t|
      t.references :school, foreign_key: true
      t.references :tournament, foreign_key: true
      t.timestamps
    end
  end
end
