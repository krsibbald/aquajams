require 'sidekiq/web'

Rails.application.routes.draw do
  root to: 'songs#index'
  mount Sidekiq::Web, at: "/sidekiq"
  
  resources :artists
  resources :cds
  resources :mixes do
    collection do
      get :upload
      post :upload
    end
  end
  resources :songs do
    collection do
      get :upload
      post :upload
    end
  end
  resources :tracks

end
