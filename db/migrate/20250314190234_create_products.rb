class CreateProducts < ActiveRecord::Migration[8.0]
  def change
    create_table :products do |t|
      t.string :name, null: false
      t.integer :price, null: false, default: 0
      t.integer :stock_quantity, null: false, default: 0

      t.timestamps
    end
  end
end
