class CategoriesController < ApplicationController
  def index
    @categories = Category.all
  end
  
  def show
    @category = Category.find_by_url(params[:id])
  end
end
