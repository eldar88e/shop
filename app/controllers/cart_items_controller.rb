class CartItemsController < ApplicationController
  before_action :set_cart_item

  def index
    @cart_items = current_cart.cart_items.includes(product: :image_attachment)
  end

  def update
    if @cart_item
      @cart_item.update!(quantity: @cart_item.quantity + 1)
    else
      current_cart.cart_items.create!(product_id: params[:id])
    end
    render turbo_stream: success_notice('Товар добавлен в корзину.')
  rescue ActiveRecord::RecordInvalid => e
    error_notice @cart_item ? @cart_item.errors.full_messages : e.message
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
