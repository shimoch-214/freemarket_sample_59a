# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  layout "application-user", except: :logout
  # before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  def new
    previous_url
    super
  end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  def destroy
    super
  end

  def logout
  end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
  private

  def previous_url
    session[:previous_url] = request.original_url
  end
end
