class Cart < ApplicationRecord
  has_many :cart_items, dependent: :destroy
  has_many :products, through: :cart_items

  enum status: { in_cart: 0, ordered: 1 }

  def total_price
    cart_items.includes(:product).sum { |item| item.quantity * item.product.price }
  end
end
