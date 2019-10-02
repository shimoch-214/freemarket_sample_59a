class CategoriesController < ApplicationController
  def index
    @parents = Category.where("ancestry is null").order("id ASC").limit(13)
  end

end
