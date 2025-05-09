Rails.application.routes.draw do
  resource :example, constraints: -> { Rails.env.development? }
  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get 'up' => 'rails/health#show', as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  root 'products#index'
  resources :cart_items, only: [:index, :update, :destroy]
  resources :carts, only: [:update, :destroy]
  resources :products, except: :show
end
