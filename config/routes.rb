Rails.application.routes.draw do
  namespace :commercial do
    resources :orders do
      member do
        patch 'cancelar'
        patch 'finalizar'
      end
    end

    # patch 'orders/:id/cancelar', to: 'orders#cancelar', as: :cancelar_pedido
		# patch 'orders/:id/finalizar', to: 'orders#finalizar', as: :finalizar_pedido

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
