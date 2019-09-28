class ItemsController < ApplicationController
  layout "application"

  def index
    @items = Item.all
  end

  def new
    @item = Item.new
    @item.build_transact
  end

  def create
  end

  def show
  end
end
