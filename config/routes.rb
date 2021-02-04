Rails.application.routes.draw do
  root 'home#index'
  resources :promotions do
      post 'generate_coupons', on: :member
  end

  resources :coupons, only: [] do
    post 'inactivate', on: :member
  end
end
