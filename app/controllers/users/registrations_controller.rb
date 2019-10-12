class Users::RegistrationsController < Devise::RegistrationsController
  layout "application-user"
  before_action :configure_sign_up_params, only: [:create]
  before_action :configure_account_update_params, only: [:update]
  before_action :reject_signed_in_user, except: [:complete, :update]

  def sign_up
    previous_url
  end

  def user_info
    session.delete(:params)
    session[:params] = {}
    @user = User.new
    @user.build_identification
  end

  def user_info_facebook
    session.delete(:params)
    user = build_sns_confirmed_user('facebook')
    render 'user_info'
  end

  def user_info_google
    session.delete(:params)
    user = build_sns_confirmed_user('google')
    render 'user_info'
  end

  def phone_number
    session[:params].merge!(user_params)
    session[:params]["identification_attributes"]["birthday"] = birthday_join
    @user = User.new(session[:params])
    # validation for recaptcha
    # unless @user.validation_in_phone_number || verify_recaptcha(model: @user)
    unless @user.validation_in_phone_number
      render 'user_info'
    end
    @user = User.new(session[:params])
  end
  
  def user_address
    session[:params].merge!(user_params)
    @user = User.new(session[:params])
    unless @user.validation_in_user_address
      render 'phone_number'
    end
    @user = User.new(session[:params])
    @user.build_address
  end

  def user_payment
    session[:params].merge!(user_params)
    @user = User.new(session[:params])
    unless @user.validation_in_user_payment
      render 'user_address'
    end
    @user = User.new(session[:params])
  end

  def create
    @user = User.new(session[:params])
    @user.identification[:zip_code] = @user.address[:zip_code]
    @user.identification[:city] = @user.address[:city]
    @user.identification[:street] = @user.address[:street]
    @user.identification[:building] = @user.address[:building]
    @user.identification[:prefecture_id] = @user.address[:prefecture_id]
      if @user.save
        session.delete(:params)
        sign_in @user unless user_signed_in?
        redirect_to registration_complete_path
      else
        render 'user_payment'
    end
  end

  def complete
  end

  def update
    if current_user.update(profile_update_params)
      redirect_to profile_mypage_path, notice: 'プロフィールを編集しました'
    else
      redirect_to profile_mypage_path, alert: 'プロフィールが編集できませんでした'
    end
  end

  private

  # get params
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
      address_attributes: [
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

  def profile_update_params
    params.require(:user).permit(:nickname, :profile)
  end

  # construct :birthday attrbute
  def birthday_join
    date = params[:birthday]
    return unless date
    return if date["birthday(1i)"].empty? || date["birthday(2i)"].empty? || date["birthday(3i)"].empty?
    Date.new date["birthday(1i)"].to_i,date["birthday(2i)"].to_i,date["birthday(3i)"].to_i
  end

  # devise sanitizer
  def configure_sign_up_params
    devise_parameter_sanitizer.permit(:sign_up, keys: [:nickname, :phone_number])
  end

  def configure_account_update_params
    devise_parameter_sanitizer.permit(:account_update, keys: [:nickname, :profile])
  end

  # build new sns_confirmation in sign_up steps
  def build_sns_confirmed_user(provider)
    @user = User.new(email: session["devise.#{provider}_data"]['info']['email'])
    @user.build_identification
    @user.build_sns_confirmation( provider: session["devise.#{provider}_data"]['provider'],
                                  uid: session["devise.#{provider}_data"]['uid'],
                                  email: session["devise.#{provider}_data"]['info']['email'])
    session[:params] = @user.attributes
    session[:params]['sns_confirmation_attributes'] = @user.sns_confirmation.attributes
    @user
  end

  # remember where from the user comes for the sns authentication
  def previous_url
    session[:previous_url] = request.original_url
  end

  # a user already signed in can not visit sign up pages
  def reject_signed_in_user
    redirect_to root_path if user_signed_in?
  end

end
