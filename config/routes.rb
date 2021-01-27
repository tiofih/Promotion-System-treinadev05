Rails.application.routes.draw do
  root 'home#index'
  resources :promotions, only: [:index]
  resources :descriptions, only: [:index]
end
