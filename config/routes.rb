Rails.application.routes.draw do

  get "/home", to: "static_pages#home"
  get "/about", to: "static_pages#about"
  root "static_pages#home"

  devise_for :users, controllers: {omniauth_callbacks: "omniauth_callbacks"}
  devise_scope :user do 
    match "/sessions/user", to: "devise/sessions#create", via: :post
  end
  resources :category, only: [:index, :show] do
    resources :products, only: [:index, :show]
  end
  resources :products do
    resources :comments
  end
  namespace :admin do
    resources :users
    resources :categories
  end
  resources :sessions, only: [:index, :create, :update, :destroy]
  resources :view, only: [:index]
  namespace :users do
    resources :orders, only: [:index, :create, :show]
  end
  get "*path", to: "static_pages#home"
end
