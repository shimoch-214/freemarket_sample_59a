class TransactsController < ApplicationController
  layout 'application-user'
  before_action :set_transact
  before_action :set_item
  require 'payjp'

  # クレジット支払い
  def pay
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
    if current_user.cards.first
      Payjp.api_key = Rails.application.credentials.payjp[:secret_key]
      @card = Card.where(user_id: current_user.id).first
      customer = Payjp::Customer.retrieve(@card.customer_id)
      @default_card_information = customer.cards.retrieve(@card.card_id)
      set_card_brand
    end
  end

  def show
  end

  private

  def set_transact
    @transact = Transact.find(params[:id])
  end

  def set_item
    @item = @transact.item
  end

  def set_card_brand
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
