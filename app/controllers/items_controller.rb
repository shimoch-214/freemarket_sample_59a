class ItemsController < ApplicationController
  layout "application-user"
  before_action :authenticate_user!

  def new
    @item = Item.new
    @item.build_transact
    @item.images.build
  end

  def create
    @item = Item.new(item_params)
    @item.transact.seller = current_user
    if @item.save
      redirect_to :root
    else
      @item.images.build if @item.images.empty?
      render 'new'
    end
  end

  def show
  end


  private
  def item_params
    params.require(:item).permit(
      :name,
      :description,
      :category_id,
      :sizing_id,
      :condition,
      :price,
      transact_attributes: [
        :bearing,
        :delivery_method,
        :prefecture_id,
        :ship_days
      ],
      images_attributes: [
        :name
      ]
    )
  end

end
