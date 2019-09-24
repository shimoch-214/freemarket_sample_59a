Rails.application.routes.draw do
  get 'mypages/show'
  get 'mypages/todo'
  get 'mypages/notification'
  devise_for :users
  resources :upload_tests, only: [:index, :create]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'products#index'

  # mypage routings
  resource :mypage, only: :show do
    member do
      get 'todo'
      get 'notification'
    end
  end
end
