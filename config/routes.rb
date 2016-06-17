Rails.application.routes.draw do
  resources :operations, only: [:index, :import_operation] do
    post :import, on: :collection
  end
  resources :companies, only: :index

  # You can have the root of your site routed with "root"
  root to: "companies#index"

end
