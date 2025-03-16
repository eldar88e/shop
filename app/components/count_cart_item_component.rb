class CountCartItemComponent < ViewComponent::Base
  def initialize(cart_item)
    @cart_item = cart_item
  end
end
