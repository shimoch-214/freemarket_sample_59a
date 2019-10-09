class CardsController < ApplicationController
  require "payjp"
  # before_action :set_card

  def show
    if current_user.cards.blank?
      render 'mypages/edit_card'
    else
      card = Card.where(user_id: current_user.id).first
      Payjp.api_key = 'sk_test_1d97aaf5c495d2023d92a2bf'
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
      render 'mypages/edit_card'
    end
  end

  # クレジットカード情報入力
  def edit
    render 'mypages/create_card'
    card = Card.where(user_id: current_user.id)
    redirect_to "/mypage/card" if card.present?
  end

  # 入力した情報をDBに保存
  def create
    Payjp.api_key = 'sk_test_1d97aaf5c495d2023d92a2bf'
    if params['payjp-token'].blank?
      redirect_to action: "edit"
    else
      customer = Payjp::Customer.create(
        email: current_user.email,
        card: params['payjp-token']
      )
      @card = Card.new(user_id: current_user.id, customer_id: customer.id, card_id: customer.default_card)
      if @card.save
        redirect_to "/mypage/card"
      else
        redirect_to action: "create"
      end
    end
  end

  #PayjpとCardデータベースを削除
  def delete
    card = Card.where(user_id: current_user.id).first
    Payjp.api_key = 'sk_test_1d97aaf5c495d2023d92a2bf'
    customer = Payjp::Customer.retrieve(card.customer_id)
    customer.delete
    card.delete
    redirect_to "/mypage/card"
  end

  # def set_card
  #   @card = Card.where(user_id: current_user.id).first if Card.where(user_id: current_user.id).present?
  # end

end
