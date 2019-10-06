class CategoriesController < ApplicationController
  def index
    @parents = Category.roots
  end

end
