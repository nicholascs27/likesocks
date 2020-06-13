Rails.application.routes.draw do
  namespace :commercial do
    resources :orders
  end
  namespace :base do
    resources :persons
    resources :product_models, expect: [:show]
    resources :products
  end

  namespace :site do
    get 'home/index'
  end

  devise_for :usuarios
  root to: 'site/home#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
