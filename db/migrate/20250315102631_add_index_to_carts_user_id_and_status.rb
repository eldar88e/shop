class AddIndexToCartsUserIdAndStatus < ActiveRecord::Migration[8.0]
  def change
    add_index :carts, [:user_id, :status]
  end
end
