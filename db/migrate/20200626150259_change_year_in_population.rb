class ChangeYearInPopulation < ActiveRecord::Migration[5.2]
  def up
    remove_column :populations, :year
    add_column :populations, :year, :integer
    add_index :populations, :year
  end
  
  def down
    remove_column :populations, :year
    add_column :populations, :year, :date
  end
end
