Rails.application.routes.draw do
  devise_for :users
  resources :upload_tests, only: [:index, :create]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'products#show'

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
