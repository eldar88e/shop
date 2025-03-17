class CartItemsController < ApplicationController
  before_action :set_cart_item

  def index
    @cart_items = current_cart.cart_items.includes(product: :image_attachment)
  end

  def update
    if @cart_item
      if params[:quantity] == 'up' || params[:quantity].blank?
        @cart_item.update!(quantity: @cart_item.quantity + 1)
      elsif params[:quantity] == 'down'
        return @cart_item.destroy! && render(turbo_stream: success_notice('Товар успешно удален.')) if @cart_item.quantity == 1

        @cart_item.update!(quantity: @cart_item.quantity - 1)
      end
    else
      current_cart.cart_items.create!(product_id: params[:id])
    end
    render turbo_stream: success_notice('Товар добавлен в корзину.')
  end

  def destroy
    @cart_item.destroy!
    redirect_to cart_items_path, flash: { notice: 'Товар успешно удален.' }
  end

  private

  def set_cart_item
    @cart_item = current_cart.cart_items.find_by(product_id: params[:id])
  end
end
