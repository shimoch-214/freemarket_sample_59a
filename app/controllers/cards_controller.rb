class CardsController < ApplicationController
  require 'payjp'
  before_action :set_card

  def index
    if current_user.cards.blank?
      render 'mypages/edit_card'
    else
      Payjp.api_key = 'sk_test_1d97aaf5c495d2023d92a2bf'
      customer = Payjp::Customer.retrieve(@card.customer_id)
      @default_card_information = customer.cards.retrieve(@card.card_id)
      set_brand
      render 'mypages/edit_card'
    end
  end

  # クレジットカード情報入力
  def new
    @card = current_user.cards.first
    if @card
      redirect_to card_path unless @card
    else
      render 'mypages/create_card'
    end
  end

  # 入力した情報をDBに保存
  def create
    Payjp.api_key = 'sk_test_1d97aaf5c495d2023d92a2bf'
    if params['payjp-token'].blank?
      render 'mypages/create_card'
    else
      customer = Payjp::Customer.create(
        email: current_user.email,
        card: params['payjp-token'],
        metadata: {user_id: current_user.id}
      )
      @card = Card.new(user_id: current_user.id, customer_id: customer.id, card_id: customer.default_card)
      if @card.save!
        redirect_to cards_path
      else
        render 'mypages/create_card'
      end
    end
  end

  #PayjpとCardデータベースを削除
  def destroy
      Payjp.api_key = 'sk_test_1d97aaf5c495d2023d92a2bf'
      customer = Payjp::Customer.retrieve(@card.customer_id)
      customer.delete
      @card.delete
      redirect_to cards_path
  end

  private

  def set_card
    @card = Card.where(user_id: current_user.id).first if Card.where(user_id: current_user.id).present?
  end

  def set_brand
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
