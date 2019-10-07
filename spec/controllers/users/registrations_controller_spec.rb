require 'rails_helper'

RSpec.describe Users::RegistrationsController, type: :controller do
  let(:user) { build(:user) }
  let(:valid_params) {{
    user: user.attributes.symbolize_keys.merge!(
      password: '12345678',
      password_confirmation: '12345678',
      identification_attributes: user.identification.attributes.symbolize_keys,
      address_attributes: user.address.attributes.symbolize_keys
    ),
    birthday: {
      'birthday(1i)' => '1994',
      'birthday(2i)' => '2',
      'birthday(3i)' => '2'
    }
  }}
  let(:invalid_params) {{
    user: {
      password: '12345678',
      password_confirmation: '123456789',
      identification_attributes: {
        id: nil,
        last_name: nil,
        first_name: nil,
        last_name_kana: nil,
        first_name_kana: nil,
        birthday: nil
      } ,
      address_attributes: {
        id: nil, 
        last_name: nil, 
        first_name: nil, 
        last_name_kana: nil, 
        first_name_kana: nil, 
        zip_code: nil,
        prefecture_id: nil,
        city: nil,
        street: nil, 
        building: nil, 
        phone_number_sub: nil
      }
    },
    birthday: {
      'birthday(1i)' => '1994',
      'birthday(2i)' => '2',
      'birthday(3i)' => '2'
    }
  }}

  before do
    request.env["devise.mapping"] = Devise.mappings[:user]
    Rails.application.env_config['omniauth.auth'] = facebook_mock
  end

  describe 'get #sign_up' do
    before do
      get :sign_up
    end
    it 'renders the :sign_up template' do
      expect(response).to render_template :sign_up
    end
    it 'stores session[:previous_url]' do
      expect(session[:previous_url]).to eq request.original_url
    end
  end

  describe 'get #user_info' do
    before do
      get :user_info
    end
    it 'renders the :user_info template' do
      expect(response).to render_template :user_info
    end
    it 'refreshes session[:params] to {}' do
      expect(session[:params]).to eq Hash.new
    end
    it 'assigns empty user to @user' do
      expect(assigns(:user)).to be_a_new User
    end
  end

  describe 'post #phone_number' do
    before do
      session[:params] = {}
    end

    it 'renders the :phone_number with valid params' do
      post :phone_number, params: valid_params
      expect(response).to render_template :phone_number
    end
    it 'renders the :user_info with invalid params' do
      post :phone_number, params: invalid_params
      expect(response).to render_template :user_info
    end
  end

  describe 'post #user_address' do
    before do
      session[:params] = {}
    end

    it 'renders the :user_address with valid params' do
      post :user_address, params: valid_params
      expect(response).to render_template :user_address
    end
    it 'renders the :phone_number with invalid params' do
      post :user_address, params: invalid_params
      expect(response).to render_template :phone_number
    end
  end

  describe 'post #user_payment' do
    before do
      session[:params] = {}
    end
    it 'renders the :user_payment with valid params' do
      post :user_payment, params: valid_params
      expect(response).to render_template :user_payment
    end
    it 'renders the :user_address with invalid params' do
      post :user_payment, params: invalid_params
      expect(response).to render_template :user_address
    end
  end

  describe 'post #create' do
    context 'with valid params' do
      it 'create the user' do
        expect {
          session[:params] = valid_params[:user]
          post :create, params: valid_params 
        }.to change{ User.count }.by(1)
      end
      it 'redirects the :complete' do
        session[:params] = valid_params[:user]
        post :create, params: valid_params 
        expect(response).to redirect_to(registration_complete_path)
      end
    end
    context 'with invalid params' do
      it 'renders the :user_payment' do
        session[:params] = invalid_params[:user]
        post :create, params: invalid_params
        expect(response).to render_template :user_payment
      end
      it 'does not create user' do
        expect{ 
          session[:params] = invalid_params[:user]
          post :create, params: invalid_params
        }.to change(User, :count).by(0)
      end
    end
  end

  describe 'get #complete' do
    it 'renders the :complete' do
      get :complete
      expect(response).to render_template :complete
    end
  end
end