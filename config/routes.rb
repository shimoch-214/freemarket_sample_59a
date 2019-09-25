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


  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'products#index'
end
