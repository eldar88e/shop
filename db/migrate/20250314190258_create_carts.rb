class CreateCarts < ActiveRecord::Migration[8.0]
  def change
    create_table :carts do |t|
      t.string :user_id
      t.integer :status, null: false, default: 0

      t.timestamps
    end

    add_index :carts, :status
  end
end
