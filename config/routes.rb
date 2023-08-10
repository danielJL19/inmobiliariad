Rails.application.routes.draw do
  resources :tags
  devise_for :users
  resources :products
  resources :categories
  get 'pages/index'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "pages#index"
end
