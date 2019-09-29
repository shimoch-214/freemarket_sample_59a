class ItemsController < ApplicationController
  layout "application"

  def index
    @items = Item.page(params[:page]).per(10).order("created_at DESC")
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
