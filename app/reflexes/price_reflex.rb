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
    result    = handler_cart_item(cart_item)
    if result.is_a? Array
      result.each do |error|
        notice = render(NoticeComponent.new(error, 'danger'), layout: false)
        cable_ready.append(selector: '#notices', html: notice).broadcast
      end
    else
      cart         = cart_item.cart
      sum_discount = Cart.where(user_id: session[:session_id]).pluck(:discount).sum
      discount     = [[DISCOUNT - sum_discount, 0].max, cart.total_price].min
      result       = render(CartPriceComponent.new(cart.cart_items, discount, cart.total_price, cart), layout: false)
      count        = render(CountCartItemComponent.new(cart_item), layout: false)
      morph "#count_block_#{cart_item.id}", count
      morph '#price_block', result
      msg = cart_item.destroyed? ? 'Товар успешно удален' : "Количество товара в корзине успешно изменено #{cart_item.quantity}"
      notice = render(NoticeComponent.new(msg, 'success'), layout: false)
      cable_ready.append(selector: '#notices', html: notice).broadcast
    end
  end

  private

  def handler_cart_item(cart_item)
    quantity  = element.dataset[:up] ? cart_item.quantity + 1 : cart_item.quantity - 1
    if cart_item.quantity > 1
      if cart_item.update(quantity: quantity)
      else
        cart_item.errors.full_messages
      end
    else
      if element.dataset[:up]
        cart_item.update(quantity: quantity)
      else
        cart_item.destroy
        cable_ready.remove(selector: cart_item)
      end
    end
  end
end
