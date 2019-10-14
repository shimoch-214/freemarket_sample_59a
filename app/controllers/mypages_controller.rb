class MypagesController < ApplicationController
  before_action :move_to_login_path

  def show
    @todos = current_user.sell_items
    @items_in_parchase = current_user.items_in_parchase
    @items_finished = current_user.items_finished
  end

  def todo
    @todos = current_user.sell_items
  end

  def notification
  end

  def profile
  end

  def edit_identification
    @identification = current_user.identification
  end

  def parchase
    @items_in_parchase = current_user.items_in_parchase
  end

  def parchased
    @items_finished = current_user.items_finished
  end

  private
  def move_to_login_path
    redirect_to user_sessions_new_path unless user_signed_in?
  end

end
