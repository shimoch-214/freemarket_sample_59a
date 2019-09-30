class Api::TransactsController < ApplicationController
  layout false

  def delivery_method
    if bearing_params[:bearing] == 'seller_side'
      @options = Transact.delivery_methods_for_seller
    else
      @options = Transact.delivery_methods
    end
  end

  private
  def bearing_params
    params.permit(:bearing)
  end
end
