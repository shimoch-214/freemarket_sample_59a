class CardsController < ApplicationController
  require "payjp"
  # before_action :set_card
  
  def show
    render 'mypages/edit_card'
  end
  
  def edit
    render 'mypages/create_card'
  end
  
end
