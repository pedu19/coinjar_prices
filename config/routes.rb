Rails.application.routes.draw do
  resources :prices do
    collection do
      post :capture
    end
    member do
      get :history
    end
    
  end

  namespace :api do
    resources :prices, only: [:create, :index]
  end
  root 'prices#index'
  get 'prices/show'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
