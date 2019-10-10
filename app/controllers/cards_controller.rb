class CardsController < ApplicationController

  def show
    render 'mypages/edit_card'
  end
  
  def edit
<<<<<<< Updated upstream
    render 'mypages/create_card'
=======
    @card = current_user.cards.first
    if @card
      redirect_to card_path unless @card
    else
      render 'mypages/create_card'
    end
  end

  # 入力した情報をDBに保存
  def create
    Payjp.api_key = Rails.application.credentials.payjp[:secret_key]
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
      Payjp.api_key = Rails.application.credentials.payjp[:secret_key]
      customer = Payjp::Customer.retrieve(@card.customer_id)
      customer.delete
      @card.delete
      redirect_to cards_path
  end

  def set_card
    @card = Card.where(user_id: current_user.id).first if Card.where(user_id: current_user.id).present?
>>>>>>> Stashed changes
  end

end
