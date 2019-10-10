class TransactsController < ApplicationController
  layout 'application-user'

  require 'payjp'

  # クレジット支払い
  def pay
    @item = set_item
    @item.transact.buyer = current_user
    card = current_user.cards.first
    Payjp.api_key = Rails.application.credentials.payjp[:secret_key]
    Payjp::Charge.create(
      amount: @item.price,
      customer: card.customer_id,
      currency: 'jpy'
    )
    transact = Transact.find(params[:id])
    transact.update(status: 1)
    @item.save
    redirect_to item_path(@item)
  end

  # 確認画面表示
  def buy
    if current_user.cards.blank?
      @item = set_item
    else  
      @item = set_item
      Payjp.api_key = Rails.application.credentials.payjp[:secret_key]
      @card = Card.where(user_id: current_user.id).first
      customer = Payjp::Customer.retrieve(@card.customer_id)
      @default_card_information = customer.cards.retrieve(@card.card_id)
      @card_brand = @default_card_information.brand      
      case @card_brand
        when "Visa"
          @card_src = "visa.svg"
        when "JCB"
          @card_src = "jcb.svg"
        when "MasterCard"
          @card_src = "master-card.svg"
        when "American Express"
          @card_src = "american_express.svg"
        when "Diners Club"
          @card_src = "dinersclub.svg"
        when "Discover"
          @card_src = "discover.svg"
      end
    end
  end

  private

  def set_item
    @item = Item.find(params[:id])
  end
end
