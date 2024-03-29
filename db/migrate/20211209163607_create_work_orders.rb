class CreateWorkOrders < ActiveRecord::Migration[6.1]
  def change
    create_table :work_orders do |t|
      t.datetime :time
      t.integer :duration
      t.decimal :price
      t.references :technician, null: false, foreign_key: true
      t.references :location, null: false, foreign_key: true

      t.timestamps
    end
  end
end
