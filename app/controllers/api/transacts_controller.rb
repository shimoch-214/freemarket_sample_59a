class Api::TransactsController < ApplicationController
  layout false

  def delivery_method
    if bearing_params[:bearing] == 'buyer_side'
      @options = Transact.delivery_methods_for_buyer_side
    else
      @options = Transact.delivery_methods
    end
  end

  private
  def bearing_params
    params.permit(:bearing)
  end
end
