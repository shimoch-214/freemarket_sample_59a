class Api::TransactsController < ApplicationController
  layout false

  def delivery_method
    if !ActiveRecord::Type::Boolean.new.cast(bearing_params[:bearing])
      @options = Transact.delivery_methods
    else
      @options = Transact.delivery_methods.slice(:pending, :yu_mail, :yu_pack, :kuroneko)
    end
  end

  private
  def bearing_params
    params.permit(:bearing)
  end
end
