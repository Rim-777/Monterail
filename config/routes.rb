require 'sidekiq/web'
Rails.application.routes.draw do
  mount Sidekiq::Web => '/sidekiq'
  resources :operations, only: :index
  resources :companies, only: :index
  resources :imports, only: [:create, :new]

  resource :search, only: :search do
    get :search
  end

  # You can have the root of your site routed with "root"
  root to: "companies#index"

end
