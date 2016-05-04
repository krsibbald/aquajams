Rails.application.routes.draw do
  root to: 'songs#index'
  
  resources :artists
  resources :cds
  resources :mixes
  resources :songs do
    collection do
      get :upload
      post :upload
    end
  end
  resources :tracks

end
