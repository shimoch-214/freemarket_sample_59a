class Users::RegistrationsController < Devise::RegistrationsController
  layout "application-user"
  before_action :configure_sign_up_params, only: [:create]
  # before_action :configure_account_update_params, only: [:update]

  def sign_up
    previous_url
  end

  def user_info
    session.delete(:params)
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
    @user = User.new
    @user.build_identification
    session[:params] = user_params
    session[:params]["identification_attributes"]["birthday"] = birthday_join
  end
  
  def user_address
    @user = User.new
    @user.build_address
    session[:params].merge!(user_params)
  end

  def user_payment
    @user = User.new
    session[:params].merge!(user_params)
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
        render 'user_info'
    end
  end

  def complete
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
      ],
      sns_confirmation_attributes: [
        :provider,
        :uid,
        :email
      ]
    )
  end

  def birthday_join
    date = params[:birthday]
    return if date["birthday(1i)"].empty? && date["birthday(2i)"].empty? && date["birthday(3i)"].empty?
    Date.new date["birthday(1i)"].to_i,date["birthday(2i)"].to_i,date["birthday(3i)"].to_i
  end

  def configure_sign_up_params
    devise_parameter_sanitizer.permit(:sign_up, keys: [:nickname, :phone_number])
  end

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

  def previous_url
    session[:previous_url] = request.original_url
  end

end
