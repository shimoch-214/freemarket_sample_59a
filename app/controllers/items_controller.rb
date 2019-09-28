class ItemsController < ApplicationController
  layout "application-user"

  def new
    @item = Item.new
    @item.build_transact
  end

  def create
  end

  def show
  end
end
