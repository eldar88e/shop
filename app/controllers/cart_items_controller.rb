class CartItemsController < ApplicationController
  def index
    @cart_items = CartItem.includes(:product).all
  end
end
