Rails.application.routes.draw do

  devise_scope :user do
    get    'signup/registration' => 'users/registrations#user_info', as: :user_info
    get    'signup/registration/facebook' => 'users/registrations#user_info_facebook', as: :user_info_facebook
    get    'signup/registration/google' => 'users/registrations#user_info_google', as: :user_info_google
    post   'signup/sms_confirmation'=> 'users/registrations#phone_number', as: :user_phone_number
    post   'signup/address' => 'users/registrations#user_address', as: :user_address
    post   'signup/payment' => 'users/registrations#user_payment', as: :user_payment
    get    'signup/complete' => 'users/registrations#complete', as: :registration_complete
    get    'sign_up' => 'users/registrations#sign_up', as: :user_sign_up 
    get    'login' => 'users/sessions#new', as: :user_sessions_new
    get    'logout' => 'users/sessions#logout', as: :user_session_logout
  end

  devise_for :users, controllers: {
    registrations:      'users/registrations',
    sessions:           'users/sessions',
    omniauth_callbacks: 'users/omniauth_callbacks'
  }

  resources :upload_tests, only: [:index, :create]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'items#index'

  # mypage routings
  resource :mypage, only: :show do
    member do
      get 'todo'
      get 'notification'
      get 'profile'
      get 'identification', to: 'mypages#edit_identification'
      get 'parchase'
      get 'parchased'
      get 'listing/listings', to: 'mypages#listings'
      get 'listing/in_progress', to: 'mypages#in_progress'
      get 'listing/completed', to: 'mypages#completed'
      resource :identification, only: :update
      # クレジットカード関連
      resources :cards , only: [:new, :index, :create, :destroy]
    end
  end

  # item exhibiting
  get 'sell', to: 'items#new', as: 'item_exhibit'
  resources :items, except: [:new] do
    namespace :api, format: 'js' do 
      resources :likes , only:[:create,:destroy]
    end
    collection do
      get :search
    end
  end

  namespace :api do
    get 'items/image'
  end
  
  # 商品取引
  # クレジット支払い
  resources :transacts, only: [:show] do
    member do
      get  'buy', to:'transacts#buy'
      post 'pay', to: 'transacts#pay'
    end
    resource :message, only: [:create]
  end

  # カテゴリー検索
  resources :categories, only:[:show,:index]


  namespace :api, format: 'html' do
    get 'categories/parent_select'
    get 'categories/child_select'
    get 'categories/grand_child_select'
    get 'transacts/delivery_method'
    post 'items_image/image'
    delete 'items_image/destroy'
  end

end
