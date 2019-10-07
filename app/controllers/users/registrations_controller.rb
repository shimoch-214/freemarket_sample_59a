# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  layout "application-user"
  before_action :configure_sign_up_params, only: [:create]
  # before_action :configure_account_update_params, only: [:update]

  def configure_sign_up_params
    devise_parameter_sanitizer.permit(:sign_up, keys: [:nickname])
    devise_parameter_sanitizer.permit(:sign_up, keys: [:phone_number])
  end

  # GET /resource/sign_up
  def new
    super
  end

  # POST /resource
    def create
      super
    end

  # GET /resource/edit
  # def edit
  #   super
  # end

  # PUT /resource
  # def update
  #   super
  # end

  # DELETE /resource
  # def destroy
  #   super
  # end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_up_params
  #   devise_parameter_sanitizer.permit(:sign_up, keys: [:attribute])
  # end

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_account_update_params
  #   devise_parameter_sanitizer.permit(:account_update, keys: [:attribute])
  # end

  # The path used after sign up.
  # def after_sign_up_path_for(resource)
  #   super(resource)
  # end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end
  def user_info
    @user = User.new
    @user.build_identification
  end

  def phone_number
    @user = User.new
    @user.build_identification
    session[:params] = user_params.to_h
    session[:params][:identification_attributes][:birthday]=birthday_join
  end
  
  def user_adress
    @user = User.new
    @user.build_adress
    session[:params].merge!(user_params.to_h)
  end

  def user_payment
    @user = User.new
    session[:params].merge!(user_params.to_h)
  end

  def create
    @user = User.new(session[:params])
    @user.identification[:zip_code] = @user.adress[:zip_code]
    @user.identification[:city] = @user.adress[:city]
    @user.identification[:street] = @user.adress[:street]
    @user.identification[:building] = @user.adress[:building]
    @user.identification[:prefecture_id] = @user.adress[:prefecture_id]
      if @user.save
        render 'create'
        session[:id] = @user.id
        sign_in User.find(session[:id]) unless user_signed_in?
    else
        render 'user_info'
    end
  end

  private

  def user_params
    params.require(:user).permit(
      :nickname,
      :email,
      :password,
      :password_confirmation,
      :phone_number,
      identification_attributes: [
        :id, 
        :last_name,
        :first_name,
        :last_name_kana,
        :first_name_kana,
        :birthday
      ],
      adress_attributes: [
        :id, 
        :last_name, 
        :first_name, 
        :last_name_kana, 
        :first_name_kana, 
        :zip_code, 
        :prefecture_id, 
        :city, 
        :street, 
        :building, 
        :phone_number_sub
      ]
    )
  end

  def birthday_join
    date = params[:birthday]
    return if date["birthday(1i)"].empty? && date["birthday(2i)"].empty? && date["birthday(3i)"].empty?
    Date.new date["birthday(1i)"].to_i,date["birthday(2i)"].to_i,date["birthday(3i)"].to_i
  end
  def sign_up
  end
end
