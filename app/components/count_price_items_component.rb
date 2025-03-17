class CountPriceItemsComponent < ViewComponent::Base
  def initialize(cart_items, cart)
    @cart_items = cart_items
    @cart = cart
  end
end
