class TransactsController < ApplicationController
  layout 'application-user'


  def buy
    @item = Item.find(params[:id])
    @user = User.find(params[:id])
  end

end
