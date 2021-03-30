class CreateTotals < ActiveRecord::Migration[6.1]
  def change
    create_table :totals do |t|
      t.datetime :fecha
      t.integer  :total

      t.timestamps
    end
  end
end
