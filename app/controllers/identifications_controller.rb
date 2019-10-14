class IdentificationsController < ApplicationController
  before_action :move_to_sign_in, unless: :user_signed_in?

  def update
    current_user.identification.update(update_params)
    redirect_back fallback_location: identification_mypage_path, notice: '本人情報を更新しました'
  end

  private
  
  def update_params
    params.require(:identification).permit(
      :zip_code,
      :prefecture_id,
      :city,
      :street,
      :building
    )
  end

  def move_to_sign_in
    redirect_to user_sessions_new_path
  end

end
