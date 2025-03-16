class CartPriceComponent < ViewComponent::Base
  def initialize(cart_items, discount, total_price, cart)
    @cart_items  = cart_items
    @discount    = discount
    @total_price = total_price
    @cart        = cart
  end
end
