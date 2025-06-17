class CheckoutController < ApplicationController
  before_action :load_products, only: [:new]

  def new
  end

  def create
    # TODO: Implement shopping basket service
  end

  private

  def load_products
    @products = Product.includes(:discount)
  end

  def checkout_params
    params.require(:basket).permit(Product.pluck(:product_code))
  end
end
