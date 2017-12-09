Rails.application.routes.draw do
  root 'rounds#index'
  resources :members
  resources :rounds
  get 'results/select', to: 'results#select'
  post 'results/table', to: 'results#table'
  get 'results/table', to: 'results#table'
  get 'results/reshuffle/:id', to: 'results#reshuffle'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
