class CategoriesController < ApplicationController
  before_action :before_show, only: [:show]
  def index
    @parents = Category.roots
  end
  
  def show
       @items = []
    if @category.descendants.empty?
       @items += @category.items
    else
       @categories=@category.descendants
       @categories.each do |category|
       @items += category.items
    end
  end
end

  def before_show
    @category=Category.find(params[:id])
  end
end
