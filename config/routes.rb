Rails.application.routes.draw do
  resources :upload_tests, only: [:index, :create]
  root to: 'upload_tests#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
