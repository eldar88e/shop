class CartItem < ApplicationRecord
  belongs_to :cart
  belongs_to :product

  validates :quantity, numericality: { greater_than: 0 }, presence: true
  validate :sufficient_stock_quantity

  private

  def sufficient_stock_quantity
    if product.stock_quantity < quantity
      errors.add(:quantity, "не хватает на складе. Доступно #{product.stock_quantity} единиц.")
    end
  end
end
