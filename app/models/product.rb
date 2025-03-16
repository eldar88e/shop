class Product < ApplicationRecord
  has_many :cart_items
  has_many :carts, through: :cart_items
  has_one_attached :image, dependent: :purge

  validates :name, presence: true
  validates :price, presence: :numericality
  validates :stock_quantity, numericality: { greater_than_or_equal_to: 0 }
end
