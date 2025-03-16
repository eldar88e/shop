class CartsController < ApplicationController
  def update
    current_cart.update!(status: :ordered, discount: params[:discount])
    redirect_to cart_items_path, flash: { notice: 'Заказ успешно оформлен!' }
  end

  def destroy
    current_cart.destroy!
    redirect_to cart_items_path, flash: { notice: 'Корзина успешно очищена!' }
  end
end
