Rails.application.routes.draw do
  root 'home#index'
  devise_for :users
  resources :promotions do
    member do
      post 'generate_coupons'
      post 'approve'
    end
  end
  get 'search', to: "promotions#search"

  resources :coupons, only: [] do
    post 'inactivate', on: :member
  end
end
