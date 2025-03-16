module CartItemsHelper
  DISCOUNT = 1000

  def discount
    [[DISCOUNT - Cart.where(user_id: session[:session_id]).sum(:discount), 0].max,
     current_cart.total_price].min
  end
end
