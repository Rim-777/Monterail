require 'sidekiq/web'
Rails.application.routes.draw do
  mount Sidekiq::Web => '/sidekiq'
  resources :operations, only: :index
  resources :companies, only: :index
  resources :imports, only: [:create, :new]

  resource :search, only: :search do
    get :search
  end

  root to: "companies#index"
end
