class CartsController < ApplicationController
  def update
    return redirect_to root_path, flash: { alert: 'Ваша корзина пуста!' } if current_cart.cart_items.empty?

    if current_cart.update(status: :ordered, discount: params[:discount])
      redirect_to cart_items_path, flash: { notice: 'Заказ успешно оформлен!' }
    else
      error_notice current_cart.errors.full_messages
    end
  end

  def destroy
    current_cart.destroy!
    redirect_to cart_items_path, flash: { notice: 'Корзина успешно очищена!' }
  end
end
