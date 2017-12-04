Rails.application.routes.draw do
  root 'rounds#index'
  resources :members
  resources :rounds
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
