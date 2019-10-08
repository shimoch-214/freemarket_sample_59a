class TransactsController < ApplicationController
  layout 'application-user'

  # require 'payjp'
  def pay
    @item = Item.find(params[:id])
    Payjp.api_key = 'sk_test_1d97aaf5c495d2023d92a2bf'
    Payjp::Charge.create(
      amount: @item.price,
      card: params['payjp-token'],
      currency: 'jpy'
    )
    redirect_to 'item_path'
  end

  def buy_complete
  end
  def buy
    @item = Item.find(params[:id])
  end
end
