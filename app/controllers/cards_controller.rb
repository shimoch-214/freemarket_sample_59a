class CardsController < ApplicationController

  def show
    render 'mypages/edit_card'
  end
  
  def edit
    render 'mypages/create_card'
  end

end
