class CreateLogs < ActiveRecord::Migration[5.2]
  def change
    create_table :logs do |t|
      t.integer :year
      t.bigint :population

      t.timestamps
    end
  end
end
