class CreateChampions < ActiveRecord::Migration[5.2]
  def change
    create_table :champions do |t|

      t.timestamps
    end
  end
end
