class Cart < ApplicationRecord
  has_many :cart_items, dependent: :destroy
  has_many :products, through: :cart_items

  enum :status, { initialized: 0, ordered: 1 }

  before_update :deduct_stock, if: -> { status_changed?(from: 'initialized', to: 'ordered') }

  def total_price
    cart_items.includes(:product).sum { |item| item.quantity * item.product.price }
  end

  private

  def deduct_stock
    cart_items.includes(:product).each do |cart_item|
      product = cart_item.product
      if product.stock_quantity >= cart_item.quantity
        product.update(stock_quantity: product.stock_quantity - cart_item.quantity)
      else
        errors.add(:base, "Недостаточно товара на складе для #{product.name}")
        throw(:abort)
      end
    end
  end
end
