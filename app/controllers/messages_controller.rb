class MessagesController < ApplicationController
  before_action :set_transact
  before_action :move_to_sign_in, unless: :user_signed_in?
  before_action :current_user_is_member?

  
  def create
    @message = Message.new(create_params)
    @message.user = current_user
    if @message.save
      redirect_to transact_path(@transact)
    else
      @item = @transact.item
      @buyer_address = @transact.buyer.address
      render template: 'transacts/show'
    end
  end

  private

  def create_params
    params.require(:message).permit(:text).merge(params.permit(:transact_id))
  end

  def set_transact
    @transact = Transact.find(params[:transact_id])
  end

  def move_to_sign_in
    redirect_to user_sessions_new_path
  end

  def current_user_is_member?
    unless @transact.seller == current_user || @transact.buyer == current_user
      redirect_to root_path, alert: '不正な操作です'
    end
  end
end
