# frozen_string_literal: true

class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def facebook ; omniauth_callback(:facebook); end
  def google_oauth2 ; omniauth_callback(:google); end

  def omniauth_callback(provider)
    @user = User.from_omniauth(request.env["omniauth.auth"])
    # sign_upから認証を行なった場合
    if session[:previous_url].include?('sign_up')
      if @user.persisted?
        redirect_to user_sign_up_path
      else
        session["devise.#{provider}_data"] = request.env["omniauth.auth"].except("extra")
        case provider.to_s
        when 'facebook'
          redirect_to user_info_facebook_path
        when 'google'
          redirect_to user_info_google_path
        end
      end
    # sign_inから認証を行なった場合
    elsif session[:previous_url].include?('login')
      if @user.persisted?
        sign_in_and_redirect @user, event: :authentication
        set_flash_message(:notice, :success, kind: "#{provider}".capitalize) if is_navigational_format?
      else
        redirect_to user_sessions_new_path
      end
    # 強引に踏まれた場合
    else
      redirect_to root_path
    end
  end

  def failure
    redirect_to root_path
  end
end
