class ProductsController < ApplicationController
  def show
    @product = Product.find params[:id]
  end

  def index
  end
end
