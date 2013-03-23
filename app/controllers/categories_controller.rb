class CategoriesController < ApplicationController
  def index
    @categories = Category.all
  end
  
  def show_name
    @category = Category.find_by_name(params[:name])
    render :show
  end
end
