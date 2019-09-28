class ItemsController < ApplicationController
  layout "application"

  def index
    @items = Item.all
  end

  def new
  end

  def create
  end

  def show
  end
end
