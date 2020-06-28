class ChangePopulationBackToBigint < ActiveRecord::Migration[5.2]
  def change
    change_column :populations, :population, :bigint
  end
end
