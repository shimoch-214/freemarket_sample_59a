Rails.application.routes.draw do

  devise_scope :user do
    get 'registrations/signup/info' => 'users/registrations#user_info', as: :user_info
    get 'registrations/signup/phone_number'=> 'users/registrations#phone_number', as: :user_phone_number
    get 'registrations/signup/adress' => 'users/registrations#user_adress', as: :user_adress
    get 'registrations/signup/payment'=> 'users/registrations#user_payment', as: :user_payment
    get 'registrations/signup/complete'=> 'users/registrations#create', as: :registration_complete
    get 'sessions/signin' => 'users/sessions#new',as: :user_sessions_new
    

    
    # get 'signup/registration' => 'users/registrations#user_payment', as: :user_registration_payment
    # get 'signup/registration/user_complete' => 'users/registrations#user_complete', as: :user_registration_complete
    # get 'sessions/log_in' => 'users/sessions#new'
    # get 'registrations/sign_up' => 'users/registrations#new'
    # get 'registrations/credit_registration' => 'users/registrations#credit_registration'

  end

  devise_for :users,controllers:{
    registrations: 'users/registrations',
    sessions:'users/sessions'
  }

  resources :upload_tests, only: [:index, :create]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'products#index'

  # mypage routings
  resource :mypage, only: :show do
    member do
      get 'todo'
      get 'notification'
      get 'profile'
      get 'identification', to: 'mypages#edit_identification'
      # メルカリのログアウトページurlは'/logout'になっているが、一旦ここに作る。
      get 'logout'
      # クレジットカード関連
      resource :card , only: [:show, :edit]
    end
  end

  # item exhibiting
  get 'sell', to: 'items#new', as: 'item_exhibit'
  resources :items, only: :create
  
  # 商品取引
  get 'transactions', to:'transactions#index'

end
