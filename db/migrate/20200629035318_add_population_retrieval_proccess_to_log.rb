class AddPopulationRetrievalProccessToLog < ActiveRecord::Migration[5.2]
  def change
    add_column :logs, :processed_as, :integer
  end
end
