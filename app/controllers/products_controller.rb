class ProductsController < ApplicationController
  before_action :set_product, only: %i[edit update destroy]

  def index
    @products = Product.all
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(product_params)
    if @product.save
      redirect_to products_path, notice: 'Товар успешно создан'
    else
      error_notice @product.errors.full_messages
    end
  end

  def edit; end

  def update
    if @product.update(product_params)
      redirect_to products_path, notice: 'Товар успешно обновлён'
    else
      error_notice @product.errors.full_messages
    end
  end

  def destroy
    @product.destroy!
    redirect_to products_path, notice: 'Товар успешно удалён'
  end

  private

  def set_product
    @product = Product.find(params[:id])
  end

  def product_params
    params.require(:product).permit(:name, :price, :stock_quantity, :image)
  end
end
