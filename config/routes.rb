Rails.application.routes.draw do

  devise_scope :user do
    get 'signup/registration/info' => 'users/registrations#user_info', as: :user_registration_info
    # get 'signup/registration' => 'users/registrations#user_number', as: :user_registration_number
    # # get 'signup/registration' => 'users/registrations#user_adress', as: :user_registration_adress
    # # get 'signup/registration' => 'users/registrations#user_payment', as: :user_registration_payment
    # # get 'signup/registration' => 'users/registrations#user_complete', as: :user_registration_complete

    
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
    end
  end
end
