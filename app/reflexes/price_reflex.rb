class PriceReflex < ApplicationReflex
  # Add Reflex methods in this file.
  #
  # All Reflex instances include CableReady::Broadcaster and expose the following properties:
  #
  #   - connection  - the ActionCable connection
  #   - channel     - the ActionCable channel
  #   - request     - an ActionDispatch::Request proxy for the socket connection
  #   - session     - the ActionDispatch::Session store for the current visitor
  #   - flash       - the ActionDispatch::Flash::FlashHash for the current request
  #   - url         - the URL of the page that triggered the reflex
  #   - params      - parameters from the element's closest form (if any)
  #   - element     - a Hash like object that represents the HTML element that triggered the reflex
  #     - signed    - use a signed Global ID to map dataset attribute to a model eg. element.signed[:foo]
  #     - unsigned  - use an unsigned Global ID to map dataset attribute to a model  eg. element.unsigned[:foo]
  #   - cable_ready - a special cable_ready that can broadcast to the current visitor (no brackets needed)
  #   - reflex_id   - a UUIDv4 that uniquely identies each Reflex
  #
  # Example:
  #
  #   before_reflex do
  #     # throw :abort # this will prevent the Reflex from continuing
  #     # learn more about callbacks at https://docs.stimulusreflex.com/lifecycle
  #   end
  #
  #   def example(argument=true)
  #     # Your logic here...
  #     # Any declared instance variables will be made available to the Rails controller and view.
  #   end
  #
  # Learn more at: https://docs.stimulusreflex.com/reflexes#reflex-classes

  DISCOUNT = 1000

  before_reflex do
  end

  def update_price
    cart_item = CartItem.find(element.dataset[:cart_item_id])
    handler_cart_item(cart_item)
    cart         = cart_item.cart
    sum_discount = Cart.where(user_id: session[:session_id]).pluck(:discount).sum
    discount     = [[DISCOUNT - sum_discount, 0].max, cart.total_price].min
    result       = render(CartPriceComponent.new(cart.cart_items, discount, cart.total_price, cart), layout: false)
    count        = render(CountCartItemComponent.new(cart_item), layout: false)
    morph "#count_block_#{cart_item.id}", count
    morph '#price_block', result
    notice = render(NoticeComponent.new('Товар добавлен в корзину.', 'success'), layout: false)
    cable_ready.append(selector: '#notices', html: notice).broadcast
  end

  private

  def handler_cart_item(cart_item)
    quantity  = element.dataset[:up] ? cart_item.quantity + 1 : cart_item.quantity - 1
    if cart_item.quantity > 1
      cart_item.update(quantity: quantity)
    else
      element.dataset[:up] ? cart_item.update(quantity: quantity) : cart_item.destroy
    end
  end
end
