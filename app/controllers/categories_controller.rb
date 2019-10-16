class CategoriesController < ApplicationController
  before_action :before_show, only: [:show]
  def index
    @parents = Category.roots
  end
  
  def show
    @items = []
    if @category.descendants.empty?
      @items=Item.where(category_id: @category).page(params[:page]).per(10)
    else
      @categories=@category.descendants.pluck(:id)
      @items=Item.where(category_id: @categories).page(params[:page]).per(10)
    end
  end

  def before_show
    @category=Category.find(params[:id])
  end
end
