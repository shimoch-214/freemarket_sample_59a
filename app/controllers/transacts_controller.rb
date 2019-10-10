class TransactsController < ApplicationController
  layout 'application-user'

  require 'payjp'

  def pay
    @item = Item.find(params[:id])
    card = current_user.cards.first
    Payjp.api_key = 'sk_test_1d97aaf5c495d2023d92a2bf'
    Payjp::Charge.create(
      amount: @item.price,
      customer: card.customer_id,
      currency: 'jpy'
    )
    transact = Transact.find(params[:id])
    transact.update(status: 1)
    redirect_to item_path(@item)
  end

  def buy_complete
  end

  def buy
    @item = Item.find(params[:id])
    Payjp.api_key = 'sk_test_1d97aaf5c495d2023d92a2bf'
    card = Card.where(user_id: current_user.id).first
    customer = Payjp::Customer.retrieve(card.customer_id)
    @default_card_information = customer.cards.retrieve(card.card_id)
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
